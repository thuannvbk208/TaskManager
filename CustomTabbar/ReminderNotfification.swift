//
//  ReminderNotfification.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/13/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class ReminderNotification {
    static let shared = ReminderNotification()
    public func requestPermission() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler:{ (granted,error) in
                if granted {
                    print("Notification access granted")
                } else{
                    print("Notification not granted")
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    public func createSchedulerNotification(title: String, description: String, timeInterval: TimeInterval, completionHandler: @escaping((_ success: Bool) -> Void)){
        if #available(iOS 10.0, *) {
            let notification = UNMutableNotificationContent()
            notification.title = title
            notification.body = description
            notification.launchImageName = "AppIcon"
            notification.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: title, content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error)
                    completionHandler(false)
                } else {
                    completionHandler(true)
                }
            }
        }
    }
    public func createSchedulerNotification(title: String, date: Date, completionHandler: @escaping((_ success: Bool) -> Void)){
        if #available(iOS 10.0, *) {
            let application = UIApplication.shared
            let notification = UNMutableNotificationContent()
            notification.title = "TaskManager"
            notification.body = title
            notification.launchImageName = "AppIcon"
            notification.sound = UNNotificationSound.default
            notification.badge = NSNumber(value: application.applicationIconBadgeNumber + 1)
            let trigerDate = Calendar.current.dateComponents([.hour,.minute,.day,.month,.year], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: trigerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: title, content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error)
                    completionHandler(false)
                } else {
                    completionHandler(true)
                }
            }
        }
    }
    
    public func getDeliveredNotifications() {
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            print("getDeliveredNotifications: \(notifications.count)")
            for notifi in notifications {
                print(notifi.request.content.body)
            }
        }
    }
    
    public func removePendingNotifications(identifier: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        } else {
            // Fallback on earlier versions
            
        }
    }
    public func removeAllPendingNotifications(identifier: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    public func removeAllDeliveredNotifications(identifier: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        } else {
            // Fallback on earlier versions
        }
    }
}
