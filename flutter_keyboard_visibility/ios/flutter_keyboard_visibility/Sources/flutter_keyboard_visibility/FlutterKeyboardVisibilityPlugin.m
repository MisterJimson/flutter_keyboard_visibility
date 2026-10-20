//
//  KeyboardVisibilityHandler.m
//  Runner
//
//  Created by admin on 07/11/2018.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "FlutterKeyboardVisibilityPlugin.h"

// Calls onResize whenever its size changes. Pinned to a keyboard layout guide,
// it reports the keyboard's frame as the guide tracks it.
@interface FKVKeyboardGuideProbe : UIView
@property (copy, nonatomic) void (^onResize)(void);
@end

@implementation FKVKeyboardGuideProbe
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.onResize) {
        self.onResize();
    }
}
@end

@interface FlutterKeyboardVisibilityPlugin() <FlutterStreamHandler>

@property (copy, nonatomic) FlutterEventSink flutterEventSink;
@property (assign, nonatomic) BOOL flutterEventListening;
@property (assign, nonatomic) BOOL isVisible;

// Whether the keyboard notifications say a docked keyboard is shown.
@property (assign, nonatomic) BOOL isDockedVisible;
// Whether the keyboard layout guide says a floating keyboard is on screen.
@property (assign, nonatomic) BOOL isFloating;
// Whether a keyboard frame change has since said the keyboard is gone, which
// the guide doesn't always show; see keyboardDidChangeFrame.
@property (assign, nonatomic) BOOL isGoneByFrame;

@property (weak, nonatomic) NSObject<FlutterPluginRegistrar> *registrar;
// A transparent view filling the window, whose keyboard layout guide follows
// an undocked keyboard, and the probe pinned to that guide.
@property (strong, nonatomic) UIView *guideHost;
@property (strong, nonatomic) FKVKeyboardGuideProbe *guideProbe;

@end


@implementation FlutterKeyboardVisibilityPlugin

+(void) registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterEventChannel *stream = [FlutterEventChannel eventChannelWithName:@"flutter_keyboard_visibility" binaryMessenger:[registrar messenger]];

    FlutterKeyboardVisibilityPlugin *instance = [[FlutterKeyboardVisibilityPlugin alloc] init];
    instance.registrar = registrar;
    [stream setStreamHandler:instance];
}

-(instancetype)init {
    self = [super init];

    self.isVisible = NO;

    // set up the notifier
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(willShow) name:UIKeyboardWillShowNotification object:nil];
	[center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    // The Flutter view can move to another window, e.g. a new scene's.
    [center addObserver:self selector:@selector(attachKeyboardGuide) name:UIWindowDidBecomeKeyNotification object:nil];

    return self;
}

- (void)didShow
{
    self.isDockedVisible = YES;
    [self updateVisibility];
}

- (void)willShow
{
    self.isDockedVisible = YES;
    [self updateVisibility];
}

- (void)didHide
{
    self.isDockedVisible = NO;
    [self updateVisibility];
}

- (void)updateVisibility
{
    BOOL visible = self.isDockedVisible || (self.isFloating && !self.isGoneByFrame);
    // if state changed and we have a subscriber, let him know
    if (visible != self.isVisible) {
        self.isVisible = visible;
        if (self.flutterEventListening) {
            self.flutterEventSink([NSNumber numberWithInt:visible ? 1 : 0]);
        }
    }
}

// An iPad's floating keyboard posts no show notification when a text field
// brings it up, and turning a docked keyboard into a floating one posts a
// hide. A keyboard layout guide that follows an undocked keyboard does track
// it, so watch one (see keyboardGuideDidChange). Before iOS 15 there is no
// such guide, and only docked keyboards are reported.
- (void)attachKeyboardGuide
{
    if (@available(iOS 15.0, *)) {
        UIWindow *window = self.registrar.viewController.view.window;
        if (window == nil || self.guideHost.window == window) {
            return;
        }
        [self.guideHost removeFromSuperview];

        UIView *host = [[UIView alloc] init];
        host.userInteractionEnabled = NO;
        host.alpha = 0;
        host.translatesAutoresizingMaskIntoConstraints = NO;
        host.keyboardLayoutGuide.followsUndockedKeyboard = YES;

        FKVKeyboardGuideProbe *probe = [[FKVKeyboardGuideProbe alloc] init];
        probe.translatesAutoresizingMaskIntoConstraints = NO;
        __weak FlutterKeyboardVisibilityPlugin *weakSelf = self;
        probe.onResize = ^{
            [weakSelf keyboardGuideDidChange];
        };

        [window addSubview:host];
        [host addSubview:probe];
        UILayoutGuide *guide = host.keyboardLayoutGuide;
        [NSLayoutConstraint activateConstraints:@[
            [host.topAnchor constraintEqualToAnchor:window.topAnchor],
            [host.bottomAnchor constraintEqualToAnchor:window.bottomAnchor],
            [host.leadingAnchor constraintEqualToAnchor:window.leadingAnchor],
            [host.trailingAnchor constraintEqualToAnchor:window.trailingAnchor],
            [probe.topAnchor constraintEqualToAnchor:guide.topAnchor],
            [probe.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor],
            [probe.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor],
            [probe.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor],
        ]];
        self.guideHost = host;
        self.guideProbe = probe;
    }
}

// Dismissing a floating keyboard on iOS 18 leaves the keyboard layout guide
// where the keyboard was; only this notification, with an all-zero end frame,
// says it has gone.
- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.isGoneByFrame = CGRectEqualToRect(frame, CGRectZero);
    [self keyboardGuideDidChange];
}

- (void)keyboardGuideDidChange
{
    CGRect frame = self.guideProbe.frame;
    CGSize host = self.guideHost.bounds.size;
    // A docked keyboard, and no keyboard (the guide then covers the bottom
    // safe area), reach the bottom edge at full width. A floating keyboard
    // doesn't: the guide takes its frame, or -- on some iOS versions, when a
    // text field brings one up -- its height and position at the window's
    // width. Dismissing one can leave the guide a sliver a few points tall
    // where it was, and iOS 27 shrinks it to a small box in the corner, hence
    // the minimum height.
    BOOL atBottom = CGRectGetMaxY(frame) >= host.height - 1;
    BOOL fullWidth = frame.size.width >= host.width - 1;
    self.isFloating = frame.size.height >= 100 && (!atBottom || !fullWidth);
    [self updateVisibility];
}

-(FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.flutterEventSink = events;
    self.flutterEventListening = YES;
    [self attachKeyboardGuide];

    // if keyboard is visible at startup, let our subscriber know
    if (self.isVisible) {
        self.flutterEventSink([NSNumber numberWithInt:1]);
    }

    return nil;
}

-(FlutterError*)onCancelWithArguments:(id)arguments {
    self.flutterEventListening = NO;
    return nil;
}

@end
