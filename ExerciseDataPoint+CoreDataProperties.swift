//
//  ExerciseDataPoint+CoreDataProperties.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 11/15/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseDataPoint {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<ExerciseDataPoint> {
        return NSFetchRequest<ExerciseDataPoint>(entityName: "ExerciseDataPoint")
    }

    @NSManaged public var type: String
    @NSManaged public var name: String
    @NSManaged public var durAndDistance: String
    @NSManaged public var timeBegan: String
    @NSManaged public var timeEntered: String

}
