library flutter_super_badge;

import 'package:flutter/foundation.dart';
import 'package:flutter_super_badge/src/android_settings.dart';
import 'package:flutter_super_badge/src/flutter_super_badge_platform_interface.dart';

export 'src/android_settings.dart';

@immutable
class FlutterSuperBadge {
  const FlutterSuperBadge({
    this.androidSettings = const AndroidSettings(),
  });

  final AndroidSettings androidSettings;

  Future<void> updateBadgeCount(int count) async {
    if (count < 0) return;

    return FlutterSuperBadgePlatform.instance.updateBadgeCount(
      count,
      androidSettings: androidSettings,
    );
  }

  Future<void> removeBadge() {
    return FlutterSuperBadgePlatform.instance.removeBadge();
  }
}
