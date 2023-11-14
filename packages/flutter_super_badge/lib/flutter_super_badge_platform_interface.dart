import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_super_badge_method_channel.dart';

abstract class FlutterSuperBadgePlatform extends PlatformInterface {
  /// Constructs a FlutterSuperBadgePlatform.
  FlutterSuperBadgePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSuperBadgePlatform _instance = MethodChannelFlutterSuperBadge();

  /// The default instance of [FlutterSuperBadgePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSuperBadge].
  static FlutterSuperBadgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSuperBadgePlatform] when
  /// they register themselves.
  static set instance(FlutterSuperBadgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isAppBadgeSupported() {
    throw UnimplementedError('isAppBadgeSupported() has not been implemented.');
  }
}
