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

class HomeViewController: UITableViewController {
    
    var choices = ["Enter a meal", "Activity Data"] //left off here
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        //Authorize permission for healthkit


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
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mealViewController) as? MealViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.activityViewController) as? ActivityDataViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        //storyboard might be present or nil, so use ? - optional chaining
        //instantiateViewController might fail if not "Detail"
        //typecast might fail
        //if statement guarentee in safestate before steps taken
        
    }
    
    
    
    
    
    
}

