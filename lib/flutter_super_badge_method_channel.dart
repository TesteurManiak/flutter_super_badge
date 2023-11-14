import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_super_badge_platform_interface.dart';

/// An implementation of [FlutterSuperBadgePlatform] that uses method channels.
class MethodChannelFlutterSuperBadge extends FlutterSuperBadgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_super_badge');

  @override
  Future<bool> isAppBadgeSupported() {
    return methodChannel
        .invokeMethod<bool>('isAppBadgeSupported')
        .then((value) => value ?? false);
  }

  @override
  Future<void> updateBadgeCount(int count) {
    return methodChannel.invokeMethod<void>('updateBadgeCount', count);
  }

  @override
  Future<void> removeBadge() {
    return methodChannel.invokeMethod<void>('removeBadge');
  }
}
