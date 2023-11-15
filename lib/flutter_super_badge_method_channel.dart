import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_super_badge_platform_interface.dart';

/// An implementation of [FlutterSuperBadgePlatform] that uses method channels.
class MethodChannelFlutterSuperBadge extends FlutterSuperBadgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_super_badge');

  @override
  Future<bool> isAppBadgeSupported() async {
    final result =
        await methodChannel.invokeMethod<bool>('isAppBadgeSupported');
    return result ?? false;
  }

  @override
  Future<void> updateBadgeCount(int count) async {
    await methodChannel.invokeMethod('updateBadgeCount', count);
  }

  @override
  Future<void> removeBadge() async {
    await methodChannel.invokeMethod('removeBadge');
  }
}
