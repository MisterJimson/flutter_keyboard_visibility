package com.jrai.flutter_keyboard_visibility;

import android.app.Activity;
import android.graphics.Rect;
import android.os.Build;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowInsets;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;


public class FlutterKeyboardVisibilityPlugin
    implements FlutterPlugin,
        ActivityAware,
        EventChannel.StreamHandler,
        ViewTreeObserver.OnGlobalLayoutListener {
  private EventChannel.EventSink eventSink;
  private View mainView;
  private boolean isVisible;

  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    init(flutterPluginBinding.getBinaryMessenger());
  }

  private void init(BinaryMessenger messenger) {
    final EventChannel eventChannel = new EventChannel(messenger, "flutter_keyboard_visibility");
    eventChannel.setStreamHandler(this);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    unregisterListener();
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    listenForKeyboard(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    unregisterListener();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    listenForKeyboard(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivity() {
    unregisterListener();
  }

  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    this.eventSink = eventSink;
  }

  @Override
  public void onCancel(Object o) {
    this.eventSink = null;
  }

  @Override
  public void onGlobalLayout() {
    if (mainView != null) {
      final boolean newState;
      final WindowInsets rootWindowInsets = mainView.getRootWindowInsets();

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && rootWindowInsets != null) {
        newState = rootWindowInsets.isVisible(WindowInsets.Type.ime());
      } else {
        final Rect visibleDisplayFrame = new Rect();
        mainView.getWindowVisibleDisplayFrame(visibleDisplayFrame);

        // On older Android releases, treat the keyboard as visible when it
        // occupies more than 15% of the root view.
        newState =
            ((double) visibleDisplayFrame.height()
                    / (double) mainView.getRootView().getHeight())
                < 0.85;
      }

      if (newState != isVisible) {
        isVisible = newState;
        if (eventSink != null) {
          eventSink.success(isVisible ? 1 : 0);
        }
      }
    }
  }

  private void listenForKeyboard(Activity activity) {
    mainView = activity.<ViewGroup>findViewById(android.R.id.content);
    mainView.getViewTreeObserver().addOnGlobalLayoutListener(this);
  }

  private void unregisterListener() {
    if (mainView != null) {
      mainView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
      mainView = null;
    }
  }
}
