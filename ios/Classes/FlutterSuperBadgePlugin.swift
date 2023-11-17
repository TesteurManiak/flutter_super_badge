import Flutter
import UIKit

public class FlutterSuperBadgePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_super_badge", binaryMessenger: registrar.messenger())
        let instance = FlutterSuperBadgePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "updateBadgeCount":
            guard let count = call.arguments as? Int else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid count value", details: nil))
                return
            }
            updateBadgeCount(count: count, result: result)
        case "removeBadge":
            updateBadgeCount(count: 0, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func updateBadgeCount(count: Int, result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            self.enableNotifications()
            
            if #available(iOS 16.0, *) {
                let center = UNUserNotificationCenter.current()
                center.setBadgeCount(count) { (error) -> () in
                    if (error == nil) {
                        result(nil)
                        return
                    }
                    result(
                        FlutterError(
                            code: "UPDATE_BADGE_FAILED",
                            message: error.debugDescription,
                            details: nil
                        )
                    )
                }
            } else {
                UIApplication.shared.applicationIconBadgeNumber = count
                result(nil)
            }
            
        }
    }
    
    private func enableNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
            if error == nil {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
