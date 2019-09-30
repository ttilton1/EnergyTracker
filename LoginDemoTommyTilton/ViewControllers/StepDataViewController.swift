//
//  StepDataViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/29/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class StepDataViewController: UIViewController {

    @IBOutlet weak var stepsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(stepsButton)

        // Do any additional setup after loading the view.
    }
    @IBAction func stepsPressed(_ sender: Any) {
        let healthKitStore = HKHealthStore()
        let type = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let todayBeg = Calendar.current.startOfDay(for: now)
        let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
        var interval = DateComponents()
        interval.hour = 1
        print("Hello")
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: todayBeg, intervalComponents: interval)
        
        query.initialResultsHandler = { query, results, error in
            
            print("inside")
            let endDate = Date()
            let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
            if let myResults = results{
                print("double inside")
                myResults.enumerateStatistics(from: startDate, to: endDate) {
                    
                    statistics, stop in
                    print("tripple inside")
                    let quantity = statistics.sumQuantity()
                    print("4 inside")
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
                        }
                        
                    }
                }
                //self.stepArray[myString] = steps
                
                //  print("\(date): steps = \(steps)")
                
                //    }
                //next step look at guard statement instead of if let above **********************************************
                
            }
        }
        
        healthKitStore.execute(query)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
