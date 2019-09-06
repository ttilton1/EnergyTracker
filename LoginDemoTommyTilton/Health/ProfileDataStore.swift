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

 /*

    
func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    /*
        let now = Date()
    
    guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now) else { return Error }
 */
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
    
    let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
        guard let result = result, let sum = result.sumQuantity() else {
            completion(0.0)
        
            return
        }
        completion(sum.doubleValue(for: HKUnit.count()))
    }
    
    healthStore.execute(query)
    }
*/
    /*
    class func getAgeSexAndBloodType() throws -> (age: Int,
        biologicalSex: HKBiologicalSex,
        bloodType: HKBloodType) {
            
            let healthKitStore = HKHealthStore()
            
            do {
                
                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try healthKitStore.
                let biologicalSex =       try healthKitStore.biologicalSex()
                let bloodType =           try healthKitStore.bloodType()
                
                //2. Use Calendar to calculate age.
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let thisYear = todayDateComponents.year!
                let age = thisYear - birthdayComponents.year!
                
                //3. Unwrap the wrappers to get the underlying enum values.
                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                let unwrappedBloodType = bloodType.bloodType
                
                return (age, unwrappedBiologicalSex, unwrappedBloodType)
            }
            */
    



}


