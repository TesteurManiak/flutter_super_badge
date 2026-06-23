import 'package:pigeon/pigeon.dart';

/// Customization options for the notification displayed **on Android only**.
class AndroidBadgeSettings {
  AndroidBadgeSettings({required this.message, required this.icon});

  /// Callback used to localize the count string.
  ///
  /// Defaults to: "You have $count notification(s)"
  String message;

  /// Specifies the icon to be used in the notification.
  String? icon;
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/gen/method_channel_message.dart',
    javaOut:
        'android/src/main/java/com/maniak/flutter_super_badge/MethodChannelMessages.java',
    javaOptions: JavaOptions(
      package: 'com.maniak.flutter_super_badge',
      className: 'MethodChannelMessages',
    ),
    swiftOut: 'ios/Classes/MethodChannelMessages.g.swift',
  ),
)
@HostApi()
abstract class FlutterSuperBadgeApi {
  void updateBadgeCount({
    required int count,
    required AndroidBadgeSettings settings,
  });

  void removeBadge();
}
