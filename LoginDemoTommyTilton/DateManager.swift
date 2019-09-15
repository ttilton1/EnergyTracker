//
//  DateRandomizer.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/14/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation

class DateManager {
    var notification1 = [DateComponents]()
    var notification2 = [DateComponents]()
    var notification3 = [DateComponents]()
    
    var mealNotification1 = [DateComponents]()
    var mealNotification2 = [DateComponents]()
    
    func assignDateComponents() {
        self.getDateComponents(timeZoneOfDay: 1)
        self.getDateComponents(timeZoneOfDay: 2)
        self.getDateComponents(timeZoneOfDay: 3)
        self.getMealDateComponents(timeOfDay: 1)
        self.getMealDateComponents(timeOfDay: 2)
    }
    
    private func getDateComponents(timeZoneOfDay: Int) {
        // let timeZoneOfDay: Int = 1
        var dateComponents = [DateComponents]()
        let appendDateComponent: Int = timeZoneOfDay
        let date = Date()
        let calendar = Calendar.current
        for n in 0 ... 6 {
            let newDay = calendar.date(byAdding: .day, value: n, to: date)!
            let year = calendar.component(.year, from: newDay)
            let month = calendar.component(.month, from: newDay)
            let day = calendar.component(.day, from: newDay)
            
            var randomTime: Double = 0.0
            switch timeZoneOfDay {
            case 1:
                randomTime = Double.random(in: 8.00 ..< 12.67)
            case 2:
                randomTime = Double.random(in: 12.67 ..< 17.34)
            case 3:
                randomTime = Double.random(in: 17.34 ..< 22.01)
            default:
                randomTime = Double.random(in: 8.0 ..< 22.01)
            }
            let (hour, minute) = modf(randomTime)
            
            let dateComponent = DateComponents(calendar: Calendar.current, year: year, month: month, day: day, hour: Int(hour), minute: Int(minute*60))
            dateComponents.append(dateComponent)
        }//end for loop
        switch appendDateComponent {
        case 1:
            notification1 = dateComponents
        case 2:
            notification2 = dateComponents
        case 3:
            notification3 = dateComponents
        default:
            print("Error establishing date componenet")
        }
    } //end getDateComponents
    
    private func getMealDateComponents(timeOfDay: Int) {
        var dateComponents = [DateComponents]()
        let date = Date()
        let calendar = Calendar.current
        for n in 0 ... 6 {
            let newDay = calendar.date(byAdding: .day, value: n, to: date)!
            let year = calendar.component(.year, from: newDay)
            let month = calendar.component(.month, from: newDay)
            let day = calendar.component(.day, from: newDay)
            
            var randomTime: Double = 0.0
            switch timeOfDay {
            case 1:
                randomTime = 13.09
            case 2:
                randomTime = 20.00
            default:
                randomTime = 20.00
            }
            let (hour, minute) = modf(randomTime)
            
            let dateComponent = DateComponents(calendar: Calendar.current, year: year, month: month, day: day, hour: Int(hour), minute: Int(minute*60))
            dateComponents.append(dateComponent)
        }//end for loop
        switch timeOfDay {
        case 1:
            mealNotification1 = dateComponents
        case 2:
            mealNotification2 = dateComponents
        default:
            print("Error establishing meal reminder date componenet")
        }
    }
    
    

    
    
}
