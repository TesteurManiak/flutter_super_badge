import 'package:flutter/foundation.dart';

typedef CountStringLocalization = String Function(int count);

/// {@template android_settings}
/// Customization options for the notification displayed **on Android only**.
/// {@endtemplate}
@immutable
class AndroidSettings {
  /// {@macro android_settings}
  const AndroidSettings({
    this.countStringLocalization = _defaultCountStringLocalization,
    this.icon,
  });

  /// Callback used to localize the count string.
  ///
  /// Defaults to: "You have $count notification(s)"
  final CountStringLocalization countStringLocalization;

  /// Specifies the icon to be used in the notification.
  final String? icon;
}

String _defaultCountStringLocalization(int count) {
  final buffer = StringBuffer("You have $count notification");
  if (count > 1) buffer.write("s");
  return buffer.toString();
}
