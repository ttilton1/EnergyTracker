//
//  HealthKitAssistantSetup.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/27/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation

import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
  //      let steps = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))

        
        //2. Prepare the data types that will interact with HealthKit
        guard let steps = HKObjectType.quantityType(forIdentifier: .stepCount)
        
 /*       guard let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let distanceWalkingRunning = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate)
         
      */
        else {  completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        
        let healthKitTypesToRead: Set<HKObjectType> = [steps]
        /*
        let healthKitTypesToRead: Set<HKObjectType> = [activeEnergyBurned,
                                                       distanceWalkingRunning,
                                                       heartRate,
                                                       HKObjectType.workoutType()]
*/
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: nil,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }


    } //end authorize
}

