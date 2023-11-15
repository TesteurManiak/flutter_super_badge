import 'flutter_super_badge_platform_interface.dart';

class FlutterSuperBadge {
  Future<void> updateBadgeCount(int count) async {
    if (count < 0) return;
    return FlutterSuperBadgePlatform.instance.updateBadgeCount(count);
  }

  Future<void> removeBadge() {
    return FlutterSuperBadgePlatform.instance.removeBadge();
  }
}
