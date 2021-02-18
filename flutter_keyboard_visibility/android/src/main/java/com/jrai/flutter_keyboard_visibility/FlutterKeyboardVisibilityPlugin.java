package com.jrai.flutter_keyboard_visibility;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;

import androidx.core.view.OnApplyWindowInsetsListener;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;


public class FlutterKeyboardVisibilityPlugin implements FlutterPlugin, ActivityAware, EventChannel.StreamHandler {
  private EventChannel.EventSink eventSink;
  private View mainView;
  private boolean isVisible;

  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    init(flutterPluginBinding.getBinaryMessenger());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(PluginRegistry.Registrar registrar) {
    final FlutterKeyboardVisibilityPlugin plugin = new FlutterKeyboardVisibilityPlugin();
    plugin.init(registrar.messenger());
    plugin.listenForKeyboard(registrar.activity());
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


  private void listenForKeyboard(Activity activity) {
    mainView = activity.<ViewGroup>findViewById(android.R.id.content);

    ViewCompat.setOnApplyWindowInsetsListener(mainView, new OnApplyWindowInsetsListener() {
      @Override
      public WindowInsetsCompat onApplyWindowInsets(View v, WindowInsetsCompat insets) {
        isVisible = insets.isVisible(WindowInsetsCompat.Type.ime());
        if (eventSink != null) {
          eventSink.success(isVisible ? 1 : 0);
        }
        return insets;
      }
    });
  }

  private void unregisterListener() {
    if (mainView != null) {
      ViewCompat.setOnApplyWindowInsetsListener(mainView,null);
      mainView = null;
    }
  }
}
