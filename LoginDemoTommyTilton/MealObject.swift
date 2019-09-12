//
//  MealObject.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/6/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation

class MealObject {
    
    var location: String
    var foodContent: String
    var mealSize: String
    var dateEaten: String
    var timeEntered: String
    
    
    init(location: String, foodContent: String, mealSize: String, dateEaten: String, timeEntered: String) {
        self.location = location
        self.foodContent = foodContent
        self.mealSize = mealSize
        self.dateEaten = dateEaten
        self.timeEntered = timeEntered
    }
    
    init() {
        self.location = ""
        self.foodContent = ""
        self.mealSize = ""
        self.dateEaten = ""
        self.timeEntered = ""
    }
    
    func returnDocData() -> [String: Any] {
        let ret: [String: Any] = ["food content":self.foodContent, "location":self.location, "meal size":self.mealSize, "dateEaten":self.dateEaten, "timeEntered":self.timeEntered]
        return ret
    }
    
    func setFromDocData(meal: [String: Any]) -> () {
        self.location = meal["location"] as? String ?? ""
        self.foodContent = meal["food content"] as? String ?? ""
        self.mealSize = meal["meal size"] as? String ?? ""
        self.dateEaten = meal["dateEaten"] as? String ?? ""
        self.timeEntered = meal["timeEntered"] as? String ?? ""
    }

}
