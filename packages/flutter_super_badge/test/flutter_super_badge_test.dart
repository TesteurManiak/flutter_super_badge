import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_super_badge/flutter_super_badge.dart';
import 'package:flutter_super_badge/flutter_super_badge_platform_interface.dart';
import 'package:flutter_super_badge/flutter_super_badge_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSuperBadgePlatform
    with MockPlatformInterfaceMixin
    implements FlutterSuperBadgePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSuperBadgePlatform initialPlatform = FlutterSuperBadgePlatform.instance;

  test('$MethodChannelFlutterSuperBadge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSuperBadge>());
  });

  test('getPlatformVersion', () async {
    FlutterSuperBadge flutterSuperBadgePlugin = FlutterSuperBadge();
    MockFlutterSuperBadgePlatform fakePlatform = MockFlutterSuperBadgePlatform();
    FlutterSuperBadgePlatform.instance = fakePlatform;

    expect(await flutterSuperBadgePlugin.getPlatformVersion(), '42');
  });
}
