//
//  DisplayMealTableViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/6/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import CoreData

class DisplayMealTableViewController: UITableViewController {
    //Firebase
    /*
    var Meals = [MealObject]()
    */
    //coreData - hackingwithswift
    var container: NSPersistentContainer!
    var mealDataPoints = [MealDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        title = "Meal History"
        
        //CoreData hacking with swift
        container = NSPersistentContainer(name: "PontzerDemoTommyTilton")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        loadSavedData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealDataPoints.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mealDisp", for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mealDisp")
        }
        let mealDataPoint = mealDataPoints[indexPath.row]
        cell.textLabel!.text = mealDataPoint.dateEaten
        cell.detailTextLabel!.text = mealDataPoint.foodContent


        return cell
    }
 
    func loadSavedData() {
        let request = MealDataPoint.createFetchRequest()
        let sort = NSSortDescriptor(key: "dateEaten", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            mealDataPoints = try container.viewContext.fetch(request)
            print("Got \(mealDataPoints.count) commits")
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }

}
