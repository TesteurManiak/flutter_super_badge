package com.maniak.flutter_super_badge;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationCompat.Builder;

import com.maniak.flutter_super_badge.MethodChannelMessages.AndroidBadgeSettings;
import com.maniak.flutter_super_badge.MethodChannelMessages.FlutterError;
import com.maniak.flutter_super_badge.MethodChannelMessages.FlutterSuperBadgeApi;

import me.leolin.shortcutbadger.ShortcutBadger;

/** Handles the messages sent from Flutter through the Pigeon-generated API. */
class MessageHandler implements FlutterSuperBadgeApi {
  static final String CHANNEL_ID = "SUPER_BADGE_CHANNEL_ID";
  private static final int NOTIFICATION_ID = 1;
  private static final String DRAWABLE = "drawable";

  private final Context applicationContext;
  private final NotificationManager notificationManager;
  private Activity activity;

  MessageHandler(@NonNull Context applicationContext) {
    this.applicationContext = applicationContext;
    this.notificationManager =
            (NotificationManager) applicationContext.getSystemService(Context.NOTIFICATION_SERVICE);
  }

  void setActivity(@Nullable Activity activity) {
    this.activity = activity;
  }

  @Override
  public void updateBadgeCount(@NonNull Long count, @NonNull AndroidBadgeSettings settings) {
    try {
      Notification notification = createNotification(settings);
      notificationManager.notify(NOTIFICATION_ID, notification);

      ShortcutBadger.applyCount(applicationContext, count.intValue());
    } catch (Exception e) {
      throw new FlutterError("UPDATE_BADGE_COUNT_FAILED", e.getMessage(), null);
    }
  }

  @Override
  public void removeBadge() {
    try {
      notificationManager.cancel(NOTIFICATION_ID);
      ShortcutBadger.removeCount(applicationContext);
    } catch (Exception e) {
      throw new FlutterError("REMOVE_BADGE_FAILED", e.getMessage(), null);
    }
  }

  private Notification createNotification(AndroidBadgeSettings settings) {
    Intent intent = activity != null ? activity.getIntent() : new Intent();

    int flags = PendingIntent.FLAG_UPDATE_CURRENT;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      flags |= PendingIntent.FLAG_IMMUTABLE;
    }

    PendingIntent pendingIntent = PendingIntent.getActivity(
            applicationContext,
            NOTIFICATION_ID,
            intent,
            flags
    );

    Builder builder = new Builder(applicationContext, CHANNEL_ID)
            .setContentTitle(settings.getMessage())
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setContentIntent(pendingIntent);

    String customIcon = settings.getIcon();
    if (customIcon == null || customIcon.isEmpty()) {
      builder.setSmallIcon(applicationContext.getApplicationInfo().icon);
    } else {
      builder.setSmallIcon(getDrawableResourceId(customIcon));
    }

    return builder.build();
  }

  @SuppressLint("DiscouragedApi")
  private int getDrawableResourceId(String name) {
    return applicationContext.getResources().getIdentifier(
            name,
            DRAWABLE,
            applicationContext.getPackageName()
    );
  }
}
