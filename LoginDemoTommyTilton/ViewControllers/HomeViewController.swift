//
//  ViewController.swift
//  PontzerMetabolics
//
//  Created by Thomas Tilton on 8/13/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import HealthKit
import CoreData
import UserNotifications

class HomeViewController: UITableViewController {
    
    var choices = ["Enter a meal", "Activity Data", "Meal History"] //left off here
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotications()
        /*Hacking with swift notification
        // Do any additional setup after loading the view.
        registerLocal()
        scheduleLocal()
 
 */ //end of hacking with swift push notifications
 
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        /* //COLOR CHANGING NOT WORKING HERE
 navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.strokeColor: UIColor.init(red: 21/255, green: 70/255, blue: 232/255, alpha: 1)]
 */
        title = "Metabolic Data Entry"
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //request new ui bar button item that is flexible space, not tapped so no target or action
        let signOut = UIBarButtonItem(title: "logout", style: .done, target: self, action: #selector(logout))
        toolbarItems = [spacer, signOut] //array with flex space and reset button, tooolbarItems comes
        navigationController?.isToolbarHidden = false //toolbar shownr
        
        //Set up push notification




        /*
        //Activity Data
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!])
            
            healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
                if !success {
                    //handle error
                    let ac = UIAlertController(title: "No activity data allowed", message: nil, preferredStyle: .actionSheet)
                    ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
                    self.present(ac, animated: true)
                    
                }
            }
        } else {
            let ac = UIAlertController(title: "Healthkit not available on device", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            self.present(ac, animated: true)
        }
        */
        
    } //End viewDidLoad()
    
    //registerNotifications 9/13/19
    func registerNotications() {
        let manager = LocalNotificationManager()
        let dateManager = DateManager()
        dateManager.assignDateComponents()
        
        for n in 0 ... 6 {
            manager.notifications.append(contentsOf: [
                
            Notification(id: "reminder-\(1+3*n)", title: "Please enter mood data in Pontzer Metabolism App, Thank you!", datetime: dateManager.notification1[n]),
            Notification(id: "reminder-\(2+3*n)", title: "Please enter mood data in Pontzer Metabolism App, Thank you!", datetime: dateManager.notification2[n]),
            Notification(id: "reminder-\(3+3*n)", title: "Please enter mood data in Pontzer Metabolism App, Thank you!", datetime:
                dateManager.notification3[n]),
            Notification(id: "MealReminder-\(1+2*n)", title: "Please remember to enter your meals in Pontzer Metabolism App", datetime:
                dateManager.mealNotification1[n]),
            Notification(id: "MealReminder-\(2+2*n)", title: "Please remember to enter your meals in Pontzer Metabolism App", datetime:
                dateManager.mealNotification2[n])
        ])
        }
        
        manager.schedule()
    }
    
    
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
    @objc func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //navigate to signup/ log in screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as UIViewController
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemChoice", for: indexPath) //creates new constant cell by dequeuing recycled cell from table, give it identifier which matches what we said in Interface Builder "Picture"
        cell.textLabel?.text = choices[indexPath.row] //gives table cell same as picture name from pictures array, ? shows may or may not be textlabel
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if choices[indexPath.row] == "Enter a meal" {
  //          let va = MealViewController(persistenceManager: PersistenceManager.shared)
 //           if let vreal = storyboard?.instantiateIni
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mealViewController) as? MealViewController {
                
                navigationController?.pushViewController(vc, animated: true)
        }
        } else if choices[indexPath.row] == "Activity Data" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.activityViewController) as? ActivityDataViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.displayMealViewController) as? DisplayMealTableViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        }
 
        //storyboard might be present or nil, so use ? - optional chaining
        //instantiateViewController might fail if not "Detail"
        //typecast might fail
        //if statement guarentee in safestate before steps taken
        
    
  /*
    func getStepsData() {
        
        // I am sendng steps to my server thats why using this variable
        //var stepsToSend = 0
        /*
        ProfileDataStore.getTodaysSteps({ (stepRetrieved) in
            stepsToSend =  Int(stepRetrieved)
        })
 */     var steps: Double
        self.getTodaysSteps(){ (result) in
        }
        
    }
    
   */
    
    
    
    
}

