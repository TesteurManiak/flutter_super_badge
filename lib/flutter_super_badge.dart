import 'flutter_super_badge_platform_interface.dart';

class FlutterSuperBadge {
  Future<bool> isAppBadgeSupported() {
    return FlutterSuperBadgePlatform.instance.isAppBadgeSupported();
  }
}
