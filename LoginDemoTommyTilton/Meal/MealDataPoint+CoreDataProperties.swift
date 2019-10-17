//
//  MealDataPoint+CoreDataProperties.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/11/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//
//

import Foundation
import CoreData


extension MealDataPoint {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MealDataPoint> {
        return NSFetchRequest<MealDataPoint>(entityName: "MealDataPoint")
    }

    @NSManaged public var location: String
    @NSManaged public var foodContent: String
    @NSManaged public var mealSize: String
    @NSManaged public var dateEaten: String
    @NSManaged public var timeEntered: String

}
