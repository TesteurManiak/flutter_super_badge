import 'package:flutter/foundation.dart';

typedef CountStringLocalization = String Function(int count);

/// {@template android_badge_configuration}
/// Customization options for the notification displayed on Android.
/// {@endtemplate}
@immutable
class AndroidBadgeConfiguration {
  /// {@macro android_badge_configuration}
  const AndroidBadgeConfiguration({
    this.countStringLocalization = _defaultCountStringLocalization,
  });

  /// Callback used to localize the count string.
  ///
  /// Defaults to: "You have $count notification(s)"
  final CountStringLocalization countStringLocalization;

  Map<String, dynamic> toArguments(int count) {
    return {
      'count': count,
      'title': countStringLocalization(count),
    };
  }
}

String _defaultCountStringLocalization(int count) {
  final buffer = StringBuffer("You have $count notification");
  if (count > 1) buffer.write("s");
  return buffer.toString();
}
