import Flutter
import UIKit

@available(iOS 16.0, *)
public class FlutterSuperBadgePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        let api = MessageHandler()
        FlutterSuperBadgeApiSetup.setUp(binaryMessenger: messenger, api: api)
    }
}
