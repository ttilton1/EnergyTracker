//
//  ActivityDataViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/27/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import HealthKit
import CoreData
import Firebase


class ActivityDataViewController: UIViewController {
    
    @IBOutlet weak var authorizeHealthData: UIButton!
  
    @IBOutlet weak var errorLabel: UILabel!
    
    var stepArray: [String: Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(authorizeHealthData)
        errorLabel.alpha = 0;
    
        

        // Do any additional setup after loading the view.
    }
    
    //IB Action
    @IBAction func authorizePressed(_ sender: Any) {
        authorizeHealthKit()

    }
    
 
    
    private func authorizeHealthKit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            if authorized == true {
                let healthKitStore = HKHealthStore()
                let type = HKQuantityType.quantityType(forIdentifier: .stepCount)!
                let now = Date()
                let todayBeg = Calendar.current.startOfDay(for: now)
                let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
                var interval = DateComponents()
                interval.hour = 1
           //     print("Hello")
                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
                let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: todayBeg, intervalComponents: interval)
                
                query.initialResultsHandler = { query, results, error in
                    
              //      print("inside")
                    let endDate = Date()
                    let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
                    if let myResults = results{
              //          print("double inside")
                        myResults.enumerateStatistics(from: startDate, to: endDate) {
                            
                            statistics, stop in
                //            print("tripple inside")
                            let quantity = statistics.sumQuantity()
                //            print("4 inside")
                            let date = statistics.startDate
                            // let steps = statistics.sumQuantity()?.doubleValue(for: HKUnit.count())
                            var steps = quantity?.doubleValue(for: HKUnit.count())
                            if steps == nil {
                                steps = 0.0
                            }
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let myString = formatter.string(from: date)
                            
                            let db = Firestore.firestore()
                            let userID = Auth.auth().currentUser!.uid
                            let doc: [String: Any] = ["steps":steps!]
                            db.collection("users").document(userID).collection("StepCounts").document(myString).setData(doc) { (error) in
                                if error != nil {
                                    self.showError("Error in saving user data")
                                } else {
                                    self.showPositive("Step Data sent! Thank you.")
                                }
                                
                            }
                        }
                        
                    }
                }
                
                healthKitStore.execute(query)
            } else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
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
