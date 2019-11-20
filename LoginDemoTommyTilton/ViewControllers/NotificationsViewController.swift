//
//  NotificationsViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 10/17/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    //IBOUTLET
    @IBOutlet weak var NotificationsButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NotificationsButtonPressed(_ sender: Any) {
        registerNotications()
        showPositive("Notifications Set Up!")
    }
    @IBAction func CancelPressed(_ sender: Any) {
        stopNotifications()
        showPositive("Notifications Cancelled")
    }
    
    func stopNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
    }
    
    
    func registerNotications() {
        let manager = LocalNotificationManager()
        let dateManager = DateManager()
        dateManager.assignDateComponents()
        
        for n in 0 ... 6 {
            manager.notifications.append(contentsOf: [
                
                Notification(id: "reminder-\(1+3*n)", title: "Please enter mood data, Thank you!", datetime: dateManager.notification1[n]),
                Notification(id: "reminder-\(2+3*n)", title: "Please enter your mood, Thank you!", datetime: dateManager.notification2[n]),
                Notification(id: "reminder-\(3+3*n)", title: "Please enter your mood data, Thank you!", datetime:
                    dateManager.notification3[n]),
                Notification(id: "MealReminder-\(1+2*n)", title: "Please remember to enter your meals", datetime:
                    dateManager.mealNotification1[n]),
                Notification(id: "MealReminder-\(2+2*n)", title: "Please remember to enter your meals", datetime:
                    dateManager.mealNotification2[n])
                ])
        }
        
        manager.schedule()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(NotificationsButton)
        Utilities.styleHollowButton(CancelButton)
        errorLabel.alpha = 0
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func showPositive(_ message: String) {
        
        errorLabel.textColor = Colors.tableViewBackgroundColor.color
        errorLabel.text = message
        errorLabel.alpha = 1
    }

}
