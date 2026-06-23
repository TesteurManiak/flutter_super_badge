//
//  MessageHandler.swift
//  Pods
//
//  Created by AdminGuigui on 19/06/2026.
//

@available(iOS 16.0, *)
class MessageHandler : NSObject, FlutterSuperBadgeApi {
    func updateBadgeCount(count: Int64, settings: AndroidBadgeSettings) throws {
        DispatchQueue.main.async {
            self.enableNotifications()
            
            UIApplication.shared.applicationIconBadgeNumber = Int(count)
        }
    }
    
    func removeBadge() throws {
        try updateBadgeCount(count: 0, settings: AndroidBadgeSettings(message: ""))
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
