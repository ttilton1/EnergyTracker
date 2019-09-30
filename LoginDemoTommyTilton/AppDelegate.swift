//
//  AppDelegate.swift
//  LoginDemoTommyTilton
//
//  Created by Thomas Tilton on 8/24/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as UIViewController
        let vc = UINavigationController(rootViewController: nav)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc

        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.mainViewController) as! UITableViewController
                let vc = UINavigationController(rootViewController: nav)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
               // appDelegate.window?.rootViewController?.addChild(vc)
                appDelegate.window?.rootViewController?.present(vc, animated: true, completion: nil)

                /*
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
                let vc = UINavigationController(rootViewController: nav)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = vc
                
                */
            }
            else {
                return
                /*
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as UIViewController
                let vc = UINavigationController(rootViewController: nav)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = vc
 */
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "PontzerDemoTommyTilton")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /*
    //User Notifications
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .provisional]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
        }
    }
*/


}

