//
//  LocalNotificationManager.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/14/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager
{
    var notifications = [Notification]()
    
    
    //good for debugging - print all pending notifications
    func listScheduleNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            for notification in notifications {
                print(notification)
            }
        }
    }
    
    //Request Permission to send Push Notifications
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted == true && error == nil {
                self.scheduleNotifications()
            }
            else {
                print("ERROR requesting authorization for push notifications")
                
            }
            
        }
    }
    //test with print statement which case is being used
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.sound = .default
            content.badge = 1;
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Notification scheduled! - ID = \(notification.id)")
            }
        }
    }
    
}
