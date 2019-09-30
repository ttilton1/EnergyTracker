//
//  ProfileDataStore.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/28/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation
import HealthKit

class ProfileDataStore {
    

    
static func getTodaysSteps(completion: @escaping (_ final: Double) -> ()) {
     let healthStore = HKHealthStore()
     let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
     /*
     let now = Date()
     
     guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now) else { return Error }
     */

     let now = Date()
     let startOfDay = Calendar.current.startOfDay(for: now)
     let startOfYesterday = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: now)!)

     let predicate = HKQuery.predicateForSamples(withStart: startOfYesterday, end: startOfDay, options: .strictStartDate)
     
     let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
     guard let result = result, let sum = result.sumQuantity()
    //    self.steps = Double(result.sumQuantity())
        else {
     
    //left off here, declare stepCount
     completion(0.0)
     return
     }
     let final = sum.doubleValue(for: HKUnit.count())
    
     completion(final)

     }

     healthStore.execute(query)
     }
    
    //Get last 7 days
static func getStepCountPerDay(completion:@escaping (_ final: Double)-> ()){
    let healthKitStore = HKHealthStore()
    let type = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let now = Date()
    let todayBeg = Calendar.current.startOfDay(for: now)
    let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
    var interval = DateComponents()
    interval.day = 1
    
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
    let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: todayBeg, intervalComponents: interval)
    
    query.initialResultsHandler = { query, results, error in
        
        
        let endDate = Date()
        let startDate = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: now)!)
        if let myResults = results{
            myResults.enumerateStatistics(from: startDate, to: endDate) {
                statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    
                    let date = statistics.startDate
                    let steps = quantity.doubleValue(for: HKUnit.count())
                    print("\(date): steps = \(steps)")
                }
            }
        }
    }
    
    healthKitStore.execute(query)
    }
 
    



}


