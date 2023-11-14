import 'flutter_super_badge_platform_interface.dart';

class FlutterSuperBadge {
  Future<bool> isAppBadgeSupported() {
    return FlutterSuperBadgePlatform.instance.isAppBadgeSupported();
  }

  Future<void> updateBadgeCount(int count) {
    return FlutterSuperBadgePlatform.instance.updateBadgeCount(count);
  }

  Future<void> removeBadge() {
    return FlutterSuperBadgePlatform.instance.removeBadge();
  }
}