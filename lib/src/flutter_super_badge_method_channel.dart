import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_super_badge/flutter_super_badge.dart';

import 'flutter_super_badge_platform_interface.dart';

/// An implementation of [FlutterSuperBadgePlatform] that uses method channels.
class MethodChannelFlutterSuperBadge extends FlutterSuperBadgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_super_badge');

  @override
  Future<void> updateBadgeCount(
    int count, {
    required AndroidBadgeConfiguration androidConfiguration,
  }) async {
    final args = switch (Platform.isAndroid) {
      true => androidConfiguration.toArguments(count),
      false => count,
    };

    await methodChannel.invokeMethod('updateBadgeCount', args);
  }

  @override
  Future<void> removeBadge() async {
    await methodChannel.invokeMethod('removeBadge');
  }
}
