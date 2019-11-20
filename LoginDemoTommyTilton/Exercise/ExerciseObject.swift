//
//  MealObject.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/6/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation

class ExerciseObject {
    
    var type: String
    var name: String
    var durAndDistance: String
    var timeBegan: String
    var timeEntered: String
    
    init(type: String, name: String, durAndDistance: String, timeBegan: String, timeEntered: String) {
        self.type = type
        self.name = name
        self.durAndDistance = durAndDistance
        self.timeBegan = timeBegan
        self.timeEntered = timeEntered
    }
    
    init() {
        self.type = ""
        self.name = ""
        self.durAndDistance = ""
        self.timeBegan = ""
        self.timeEntered = ""
    }
    
    func returnDocData() -> [String: Any] {
        let ret: [String: Any] = ["type":self.type, "name":self.name, "durAndDistance":self.durAndDistance, "timeBegan":self.timeBegan, "timeEntered":self.timeEntered]
        return ret
    }
    
    func setFromDocData(exercise: [String: Any]) -> () {
        self.type = exercise["type"] as? String ?? ""
        self.name = exercise["name"] as? String ?? ""
        self.durAndDistance = exercise["durAndDistance"] as? String ?? ""
        self.timeBegan = exercise["timeBegan"] as? String ?? ""
        self.timeEntered = exercise["timeEntered"] as? String ?? ""
    }

}
