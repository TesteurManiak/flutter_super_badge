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
        case "isAppBadgeSupported":
            result(true)
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
            if #available(iOS 16.0, *) {
                let center = UNUserNotificationCenter.current()
                center.setBadgeCount(count) { (error) -> () in
                    guard let error = error else {
                        result(
                            FlutterError(
                                code: "PLATFORM_ERROR",
                                message: error?.localizedDescription,
                                details: nil
                            )
                        )
                        return
                    }
                    result(nil)
                }
            } else {
                UIApplication.shared.applicationIconBadgeNumber = count
                result(nil)
            }
            
        }
    }
}
