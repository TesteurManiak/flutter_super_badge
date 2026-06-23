package com.maniak.flutter_super_badge;

import android.app.Activity;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;

import com.maniak.flutter_super_badge.MethodChannelMessages.FlutterSuperBadgeApi;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;

/** FlutterSuperBadgePlugin */
public class FlutterSuperBadgePlugin
        implements FlutterPlugin,
        ActivityAware,
        PluginRegistry.NewIntentListener {
  private BinaryMessenger binaryMessenger;
  private MessageHandler messageHandler;
  private Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final Context applicationContext = flutterPluginBinding.getApplicationContext();
    binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    messageHandler = new MessageHandler(applicationContext);
    FlutterSuperBadgeApi.setUp(binaryMessenger, messageHandler);
    createNotificationChannel(applicationContext);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (binaryMessenger != null) {
      FlutterSuperBadgeApi.setUp(binaryMessenger, null);
      binaryMessenger = null;
    }
    messageHandler = null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    binding.addOnNewIntentListener(this);
    attachActivity(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    attachActivity(null);
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    binding.addOnNewIntentListener(this);
    attachActivity(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivity() {
    attachActivity(null);
  }

  @Override
  public boolean onNewIntent(@NonNull Intent intent) {
    if (activity != null) {
      activity.setIntent(intent);
    }
    return false;
  }

  private void attachActivity(Activity activity) {
    this.activity = activity;
    if (messageHandler != null) {
      messageHandler.setActivity(activity);
    }
  }

  private static void createNotificationChannel(Context context) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      CharSequence name = context.getString(R.string.channel_name);
      String description = context.getString(R.string.channel_description);
      int importance = NotificationManager.IMPORTANCE_LOW;

      NotificationChannel channel = new NotificationChannel(MessageHandler.CHANNEL_ID, name, importance);
      channel.setDescription(description);
      channel.setShowBadge(true);

      NotificationManager notificationManager =
              (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
      notificationManager.createNotificationChannel(channel);
    }
  }
}
