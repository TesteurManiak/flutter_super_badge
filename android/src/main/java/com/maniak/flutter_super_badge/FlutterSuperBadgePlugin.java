package com.maniak.flutter_super_badge;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationCompat.Builder;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import me.leolin.shortcutbadger.ShortcutBadger;

/** FlutterSuperBadgePlugin */
public class FlutterSuperBadgePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;
  private NotificationManager notificationManager;

  static private final String CHANNEL_ID = "SUPER_BADGE_CHANNEL_ID";
  static private final int NOTIFICATION_ID = 1;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_super_badge");
    channel.setMethodCallHandler(this);
    applicationContext = flutterPluginBinding.getApplicationContext();
    notificationManager =
            (NotificationManager) applicationContext.getSystemService(Context.NOTIFICATION_SERVICE);
    createNotificationChannel(flutterPluginBinding.getApplicationContext());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    final String method = call.method;
    switch (method) {
      case "updateBadgeCount":
        updateBadgeCount(result, call.arguments);
        break;
      case "removeBadge":
        removeBadge(result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private void removeBadge(@NonNull Result result) {
    try {
      notificationManager.cancel(NOTIFICATION_ID);
      ShortcutBadger.removeCount(applicationContext);
      result.success(null);
    } catch (Exception e) {
      result.error("REMOVE_BADGE_FAILED", e.getMessage(), null);
    }
  }

  private void updateBadgeCount(@NonNull Result result, Object arguments) {
    try {
      final int count = Integer.parseInt(arguments.toString());
      final Notification notification = createNotification(count);
      notificationManager.notify(NOTIFICATION_ID, notification);

      ShortcutBadger.applyCount(applicationContext, count);
      result.success(null);
    } catch (Exception e) {
      result.error("UPDATE_BADGE_COUNT_FAILED", e.getMessage(), null);
    }
  }

  private Notification createNotification(int count) {
    Builder builder = new Builder(applicationContext, CHANNEL_ID)
            .setSmallIcon(applicationContext.getApplicationInfo().icon)
            // TODO(Guillaume): Localize strings
            .setContentTitle("You have " + count + " notifications")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setOngoing(true);

    return builder.build();
  }

  private static void createNotificationChannel(Context context) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      CharSequence name = context.getString(R.string.channel_name);
      String description = context.getString(R.string.channel_description);
      int importance =  NotificationManager.IMPORTANCE_DEFAULT;

      NotificationChannel channel = new NotificationChannel(CHANNEL_ID, name, importance);
      channel.setDescription(description);
      channel.setShowBadge(true);

      final NotificationManager  notificationManager =
              (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
      notificationManager.createNotificationChannel(channel);
    }
  }
}
