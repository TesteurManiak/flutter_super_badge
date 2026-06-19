import 'package:flutter/foundation.dart';

import '../flutter_super_badge.dart';
import 'flutter_super_badge_platform_interface.dart';
import 'gen/method_channel_message.dart';

class MethodChannelFlutterSuperBadge extends FlutterSuperBadgePlatform {
  @visibleForTesting
  final api = FlutterSuperBadgeApi();

  @override
  Future<void> updateBadgeCount(
    int count, {
    required AndroidSettings settings,
  }) => api.updateBadgeCount(
    count: count,
    settings: AndroidBadgeSettings(
      message: settings.countStringLocalization(count),
      icon: settings.icon,
    ),
  );

  @override
  Future<void> removeBadge() => api.removeBadge();
}
