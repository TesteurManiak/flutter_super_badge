library flutter_super_badge;

import 'package:flutter/foundation.dart';
import 'package:flutter_super_badge/src/android_badge_configuration.dart';
import 'package:flutter_super_badge/src/flutter_super_badge_platform_interface.dart';

export 'src/android_badge_configuration.dart';

@immutable
class FlutterSuperBadge {
  const FlutterSuperBadge({
    this.androidConfiguration = const AndroidBadgeConfiguration(),
  });

  final AndroidBadgeConfiguration androidConfiguration;

  Future<void> updateBadgeCount(int count) async {
    if (count < 0) return;

    return FlutterSuperBadgePlatform.instance.updateBadgeCount(
      count,
      androidConfiguration: androidConfiguration,
    );
  }

  Future<void> removeBadge() {
    return FlutterSuperBadgePlatform.instance.removeBadge();
  }
}
