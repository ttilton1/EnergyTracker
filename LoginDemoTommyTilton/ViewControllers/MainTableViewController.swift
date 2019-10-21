//
//  MainTableViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/18/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//
import UIKit
import FirebaseAuth
import Firebase
import HealthKit
import CoreData
import UserNotifications

class MainTableViewController: UITableViewController {
    
    var choices = ["Enter a meal", "Mood Level Input", "Send Step Data", "Meal History", "Authorize Notifications"] //left off here
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
      //  self.view.backgroundColor = Colors.appTintColor.color

    //   registerNotications()
        //extra setup
        tableView.tableFooterView = UIView()
    
        /*Hacking with swift notification
         // Do any additional setup after loading the view.
         registerLocal()
         scheduleLocal()
         
         */ //end of hacking with swift push notifications
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       navigationController?.navigationBar.prefersLargeTitles = true //large title
        /* //COLOR CHANGING NOT WORKING HERE
         navigationController?.navigationBar.titleTextAttributes =
         [NSAttributedString.Key.strokeColor: UIColor.init(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)]
         */
        title = "Energetics Tracker"
        navigationController?.navigationBar.barTintColor = Colors.tableViewBackgroundColor.color
        self.navigationController?.navigationBar.tintColor = UIColor.white;
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(logout))
        // toolbarItems = [spacer, signOut] //array with flex space and reset button, tooolbarItems comes
   //     navigationController?.isToolbarHidden = false //toolbar shownr
        
  
        
    } //End viewDidLoad()
    
  
    
/*
    //GOOD NOTIFICATIONS MANAGEMENT
    //registerNotifications 9/13/19
    func registerNotications() {
        let manager = LocalNotificationManager()
        let dateManager = DateManager()
        dateManager.assignDateComponents()
        
        for n in 0 ... 6 {
            manager.notifications.append(contentsOf: [
                
                Notification(id: "reminder-\(1+3*n)", title: "Please enter mood data in the Energy Tracker App, Thank you!", datetime: dateManager.notification1[n]),
                Notification(id: "reminder-\(2+3*n)", title: "Please enter mood data in the Energy Tracker App, Thank you!", datetime: dateManager.notification2[n]),
                Notification(id: "reminder-\(3+3*n)", title: "Please enter mood data in the Energy Tracker App, Thank you!", datetime:
                    dateManager.notification3[n]),
                Notification(id: "MealReminder-\(1+2*n)", title: "Please remember to enter your meals in the Energy Tracker App", datetime:
                    dateManager.mealNotification1[n]),
                Notification(id: "MealReminder-\(2+2*n)", title: "Please remember to enter your meals in the Energy Tracker App", datetime:
                    dateManager.mealNotification2[n])
                ])
        }
        
        manager.schedule()
    }
*/
    
    /*
     //local notifications
     @objc func registerLocal() {
     let center = UNUserNotificationCenter.current()
     
     center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
     if granted {
     print("Yay!")
     } else {
     print("D'oh")
     }
     }
     }
     */
    //test push
    
    /*
     func schedule()
     {
     let center = UNUserNotificationCenter.current()
     center.getNotificationSettings { settings in
     switch settings.authorizationStatus {
     case .notDetermined:
     self.registerLocal()
     case .authorized, .provisional:
     self.scheduleLocal()
     default:
     break //Do nothing
     }
     }
     }
     */
    /*
     
     //left off here
     @objc func scheduleLocal() {
     
     
     let center = UNUserNotificationCenter.current()
     
     //__________WHAT DOES THIS LINE BELOW DO___________________
     center.removeAllPendingNotificationRequests()
     
     let content = UNMutableNotificationContent()
     content.title = "Duke Metabolic's Lab"
     content.body = "Please enter your mood."
     content.categoryIdentifier = "alarm"
     content.userInfo = ["customData": "fizzbuzz"] //this is important for making it work more than once idk why
     content.sound = UNNotificationSound.default
     
     //get random time between 8 and 12.37
     var randomDate: Double = Double.random(in: 8.00 ..< 12.37)
     let (wholepart, fractionalPart) = modf(randomDate)
     
     
     var dateComponents = DateComponents()
     dateComponents.hour = Int(wholepart)
     dateComponents.minute = Int(fractionalPart*60)
     //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
     
     
     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
     let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
     center.add(request)
     }
     */
    //
    
    @objc func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        
        return topMostViewController
    }
    
    @objc func logout() {
 
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as UIViewController
            let vc = UINavigationController(rootViewController: nav)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    
    
    
    //rows stuff
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
        //override - > changing parent class, func is method, called tableView
        //parameters inside method decide what happened
        //tableView is first parameter, the one we will base number of rows off
        //2nd parameter is number of rows of section
        //pictures.count - we want as many cells there are as many pictures
    }
    
    //specialize which row look like. Row is specified at indexPath. section number and row number, 1 section so can just use row number
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "itemChoices", for: indexPath) //creates new constant cell by dequeuing recycled cell from table, give it identifier which matches what we said in Interface Builder "Picture"
        //cell.textLabel?.text = choices[indexPath.row] //gives table cell same as picture name from pictures array, ? shows may or may not be textlabel
        
        if indexPath.row == 0 {
         cell = TableCell(text: "Enter a meal", style: .default, reuseIdentifier: "itemChoices")
         } else if indexPath.row == 1 {
         cell = TableCell(text: "Mood Level Input", style: .default, reuseIdentifier: "itemChoices")
        }  else if indexPath.row == 2 {
            cell = TableCell(text: "Send Step Data", style: .default, reuseIdentifier: "itemChoices")
        } else if indexPath.row == 3 {
            cell = TableCell(text: "Meal History", style: .default, reuseIdentifier: "itemChoices")
        } else if indexPath.row == 4 {
            cell = TableCell(text: "Authorize Notifications", style: .default, reuseIdentifier: "itemChoices")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if choices[indexPath.row] == "Enter a meal" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mealViewController) as? MealViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if choices[indexPath.row] == "Mood Level Input"{
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.moodsViewController) as? MoodsViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
        } else if choices[indexPath.row] == "Send Step Data" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.activityViewController) as? ActivityDataViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if choices[indexPath.row] == "Meal History" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.displayMealViewController) as? DisplayMealTableViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if choices[indexPath.row] == "Authorize Notifications" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.NotificationsViewController) as? NotificationsViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
 
    }

    

} //end class
