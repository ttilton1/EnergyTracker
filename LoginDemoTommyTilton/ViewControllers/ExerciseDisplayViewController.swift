//
//  ExerciseDisplayViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 11/19/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import CoreData

class ExerciseDisplayViewController: UITableViewController {
    
    var container: NSPersistentContainer!
    var exerciseDataPoints = [ExerciseDataPoint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        title = "Exercise History"
        
        //CoreData hacking with swift
        container = NSPersistentContainer(name: "PontzerDemoTommyTilton")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        loadSavedData()

        // Do any additional setup after loading the view.
    }
    
        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return exerciseDataPoints.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "exerciseDisp", for: indexPath)
            if cell.detailTextLabel == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "exerciseDisp")
            }
            let exerciseDataPoint = exerciseDataPoints[indexPath.row]
            cell.textLabel!.text = exerciseDataPoint.timeBegan
            cell.detailTextLabel!.text = exerciseDataPoint.name
            return cell
        }
     
        func loadSavedData() {
            let request = ExerciseDataPoint.createFetchRequest()
            let sort = NSSortDescriptor(key: "timeBegan", ascending: false)
            request.sortDescriptors = [sort]
            
            do {
                exerciseDataPoints = try container.viewContext.fetch(request)
                print("Got \(exerciseDataPoints.count) commits")
                tableView.reloadData()
            } catch {
                print("Fetch failed")
            }
        }
        
        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        /*
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        */

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        
        /*
        func loadMeals(meals: [MealObject]) -> ([MealObject]) {
            
            var mealArray: [MealObject] = meals
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser!.uid
            
            
            db.collection("users").document(userID).collection("Meals").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                     //      print("+++++++++++++++++++++++++++++++++++++++++++")
                     //      print("\(document.documentID) => \(document.data())")
                     //       print("******************************************")
                        var apple = [String: Any]()
                        apple = document.data()
                        let meal1 = MealObject()
                        meal1.setFromDocData(meal: apple)
                                 print("++++++++++++++++++++++++++++++++++++++++++++")
                                    print("meal => \(meal1.returnDocData())")
                                      print("******************************************")
                        mealArray.append(meal1)
                        
                    }
                }
            }
            return mealArray
        }
     *///end of function

    
    /*
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
         var ExerciseDataPoints = [ExerciseDataPoint]()
         
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
             return mealDataPoints.count + ExerciseDataPoints.count
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
         
         /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
             // Return false if you do not want the specified item to be editable.
             return true
         }
         */

         /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
             if editingStyle == .delete {
                 // Delete the row from the data source
                 tableView.deleteRows(at: [indexPath], with: .fade)
             } else if editingStyle == .insert {
                 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
             }
         }
         */

         /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

         }
         */

         /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
             // Return false if you do not want the item to be re-orderable.
             return true
         }
         */

         /*
         // MARK: - Navigation

         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
         }
         */
         
         /*
         func loadMeals(meals: [MealObject]) -> ([MealObject]) {
             
             var mealArray: [MealObject] = meals
             let db = Firestore.firestore()
             let userID = Auth.auth().currentUser!.uid
             
             
             db.collection("users").document(userID).collection("Meals").getDocuments() { (querySnapshot, err) in
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                      //      print("+++++++++++++++++++++++++++++++++++++++++++")
                      //      print("\(document.documentID) => \(document.data())")
                      //       print("******************************************")
                         var apple = [String: Any]()
                         apple = document.data()
                         let meal1 = MealObject()
                         meal1.setFromDocData(meal: apple)
                                  print("++++++++++++++++++++++++++++++++++++++++++++")
                                     print("meal => \(meal1.returnDocData())")
                                       print("******************************************")
                         mealArray.append(meal1)
                         
                     }
                 }
             }
             return mealArray
         }
      *///end of function

     }
**/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
