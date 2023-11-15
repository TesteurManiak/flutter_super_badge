# flutter_super_badge

A native plugin to update the app badge count on the app icon.

Inspired by [flutter_app_badger][flutter_app_badger] & [flutter_app_badge_control][flutter_app_badge_control].

## Supported Platforms

|                       | Android | iOS |
| --------------------- | ------- | --- |
| `isAppBadgeSupported` | ✅      | ✅  |
| `updateBadgeCount`    | ✅      | ✅  |
| `removeBadge`         | ✅      | ✅  |

## Getting Started

### iOS

On iOS you will have to request for notification permissions (e.g. with [permission_handler][permission_handler])

```dart
Permission.notification.isDenied.then((value) {
    if (value) Permission.notification.request();
});
```

Also add the following to your `Info.plist` file:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### Android

There's no official API to update the app badge count on Android. But some launchers support it. The integration is done via the [ShortcutBadgerX][shortcutbadgerx] (forked from [ShortcutBadger][shortcutbadger]) library.

#### Supported Launchers

<table>
    <tr>
        <td width="130">
            <h3>Sony</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_sony.png"/>
        </td>
        <td width="130">
            <h3>Samsung</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_samsung.png"/>
        </td>
        <td width="130">
            <h3>LG</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_lg.png"/>
        </td>
        <td width="130">
            <h3>HTC</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_htc.png"/>
        </td>
    </tr>
    <tr>
        <td width="130">
            <h3>Xiaomi</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_xiaomi.png"/>
        </td>
        <td width="130">
            <h3>ASUS</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_asus.png"/>
        </td>
        <td width="130">
            <h3>ADW</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_adw.png"/>
        </td>
        <td width="130">
            <h3>APEX</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_apex.png"/>
        </td>
    <tr>
        <td width="130">
            <h3>NOVA</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_nova.png"/>
        </td>
        <td width="130">
            <h3>Huawei</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_huawei.png"/>
            (1.1.7+)
        </td>
        <td width="130">
            <h3>ZUK</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_zuk.png"/>
            (1.1.10+)
        </td>
        <td width="130">
            <h3>OPPO</h3>
            <img src="https://raw.githubusercontent.com/leolin310148/ShortcutBadger/master/screenshots/ss_oppo.png"/>
            (1.1.10+)
        </td>
    </tr>
    <tr>
        <td width="130">
            <h3>EverythingMe</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_evme.png"/>
        </td>
        <td width="130">
            <h3>ZTE</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_zte.png"/>
            (1.1.17+)
        </td>
        <td width="260" colspan="2">
            <h3>KISS</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_kiss.png"/>
            (1.1.18+)
        </td>
    </tr>
    <tr>
        <td width="130">
            <h3>LaunchTime</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_launchtime.png"/>
        </td>
        <td width="130">
            <h3>Yandex</h3>
            <img src="https://raw.github.com/leolin310148/ShortcutBadger/master/screenshots/ss_yandex.png"/>
            (1.1.23+)
        </td>
    </tr>
</table>

* Nova launcher with TeslaUnread, Apex launcher, ADW Launcher provided by [notz](https://github.com/notz)
* Solid launcher provided by [MajeurAndroid](https://github.com/MajeurAndroid)
* KISS Launcher provided by [alexander255](https://github.com/alexander255)


[flutter_app_badger]: https://pub.dev/packages/flutter_app_badger
[flutter_app_badge_control]: https://pub.dev/packages/flutter_app_badge_control
[permission_handler]: https://pub.dev/packages/permission_handler
[shortcutbadgerx]: https://github.com/rlgo/ShortcutBadgerX
[shortcutbadger]: https://github.com/leolin310148/ShortcutBadger