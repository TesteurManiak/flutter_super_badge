
import 'flutter_super_badge_platform_interface.dart';

class FlutterSuperBadge {
  Future<String?> getPlatformVersion() {
    return FlutterSuperBadgePlatform.instance.getPlatformVersion();
  }
}
