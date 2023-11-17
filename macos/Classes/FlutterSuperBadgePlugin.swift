import Cocoa
import FlutterMacOS

public class FlutterSuperBadgePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_super_badge", binaryMessenger: registrar.messenger)
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
            updateBadgeCount(count: nil, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func updateBadgeCount(count: Int?, result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            NSApplication.shared.dockTile.badgeLabel = count.flatMap(String.init)
            result(nil)
        }
    }
}
