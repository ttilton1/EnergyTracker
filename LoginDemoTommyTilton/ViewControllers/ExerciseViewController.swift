//
//  ExerciseViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 11/5/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//



import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import CoreData
import HealthKit
import FirebaseDatabase

class ExerciseViewController: UIViewController, UITextFieldDelegate {
    //Textfields
    @IBOutlet weak var ExerciseType: UITextField!
    @IBOutlet weak var ExerciseName: UITextField!
    @IBOutlet weak var DurAndDistance: UITextField!
    @IBOutlet weak var StartTime: UITextField!
    //Buttons
    @IBOutlet weak var SubmitButton: UIButton!
    //Label
    @IBOutlet weak var ErrorLabel: UILabel!
    
    var container: NSPersistentContainer!
    var ExerciseDataPoints = [ExerciseDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements();
        self.ExerciseType.delegate = self
        self.ExerciseName.delegate = self
        self.DurAndDistance.delegate = self
        //***************************THIS LINE BELOW MAY BE WRONG
        self.StartTime.delegate = self
        //coredata persistence
        //persistenceManager.
        title = "Exercise Entry"
        
        container = NSPersistentContainer(name: "PontzerDemoTommyTilton")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
    }
    
    
    func setUpElements() {
        
        //hide error label
        ErrorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(ExerciseName)
        Utilities.styleTextField(ExerciseType)
        Utilities.styleTextField(DurAndDistance)
        Utilities.styleTextField(StartTime)
        Utilities.styleFilledButton(SubmitButton)
    }
    func validateFields() -> String? {
        if ExerciseType.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ExerciseName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            DurAndDistance.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            StartTime.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message: String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    @IBAction func EditingBegin(_ sender: UITextField) {
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
         //    dateFormatter.dateStyle = DateFormatter.Style.medium
        //     dateFormatter.timeStyle = DateFormatter.Style.medium
             StartTime.text = dateFormatter.string(from: Date())
             //setup datepicker
             let datePickerView:UIDatePicker = UIDatePicker()
             datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
              sender.inputView = datePickerView
             datePickerView.addTarget(self, action: #selector(ExerciseViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
         }
         
         @objc func datePickerValueChanged(sender:UIDatePicker){
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
             StartTime.text = dateFormatter.string(from: sender.date)
             //get it in version we want to store for organization
         }
    //%%%%%%%%%%%%LEFT OF HERE%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    @IBAction func SubmitPressed(_ sender: Any) {
        let error = validateFields()
             if error != nil {
                 //there was an error, something wrong with fields, show error message
                 showError(error!)
             }
             else {
                 

                 //create clean versions of the data
                 let exerciseType = ExerciseType.text!.trimmingCharacters(in: .newlines)
                 let durAndDistance = DurAndDistance.text!.trimmingCharacters(in: .newlines)
                 let exerciseName = ExerciseName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                 let timeEntered = getCurrentStringDate()
                     //NSDate().timeIntervalSince1970
                 let userID = Auth.auth().currentUser!.uid

                 let timeBegan = StartTime.text!
        
                 //instantiate meal object
               let exercise1 = ExerciseObject(type: exerciseType, name: exerciseName, durAndDistance: durAndDistance, timeBegan: timeBegan, timeEntered: timeEntered)
                 
                 //instantiate Database data array
                 let docData = exercise1.returnDocData()
                 
                 //User was created successfully, now store first and last name in new "document" in firestore
                 let db = Firestore.firestore()
                 db.collection("users").document(userID).collection("Exercises").document(timeBegan).setData(docData) { (error) in
                         if error != nil {
                             self.showError("Error in saving user data")
                         }
                     
                     }
                 //Save to Firebase realtime database
                 var ref: DatabaseReference!

                 ref = Database.database().reference()
                 ref.child("Users").child(userID).child("Exercises").child(timeBegan).updateChildValues(docData)
                 { (error, databaserefval)  in
                 if error != nil {
                     self.showError("Error in saving user realtime data")
                 }
                 }
                 //save Data locally to Core Data
                 
                 let exerciseDataPoint = ExerciseDataPoint(context: self.container.viewContext)
                 exerciseDataPoint.timeBegan = exercise1.timeBegan
                 exerciseDataPoint.name = exercise1.name
                 exerciseDataPoint.durAndDistance = exercise1.durAndDistance
                 exerciseDataPoint.type = exercise1.type
                 exerciseDataPoint.timeEntered = exercise1.timeEntered
                 self.saveContext()
                
                
                //Exit back to table view
                navigationController?.popViewController(animated: true)
                         
    }
        
    
        
        
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func getCurrentStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
     //   formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let stringDate = formatter.string(from: yourDate!)
        return stringDate
    }

    
    /*
     
    @IBAction func SubmitPressed(_ sender: Any) {
          
                let error = validateFields()
                if error != nil {
                    //there was an error, something wrong with fields, show error message
                    showError(error!)
                }
                else {
                    
                    /*
                     ExerciseType: UITextField!
                     @IBOutlet weak var ExerciseName: UITextField!
                     @IBOutlet weak var DurAndDistance: UITextField!
                     @IBOutlet weak var StartTime: UITextField!
                     */
                     
                    
                    //create clean versions of the data
                    let exerciseType = ExerciseType.text!.trimmingCharacters(in: .newlines)
                    let durAndDistance = DurAndDistance.text!.trimmingCharacters(in: .newlines)
                    let exerciseName = ExerciseName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let timeEntered = getCurrentStringDate()
                        //NSDate().timeIntervalSince1970
                    let userID = Auth.auth().currentUser!.uid

                    let timeBegan = StartTime.text!
           
                    //instantiate meal object
                  let exercise1 = ExerciseObject(type: exerciseType, name: exerciseName, durAndDistance: durAndDistance, timeBegan: timeBegan, timeEntered: timeEntered)
                    
                    //instantiate Database data array
                    let docData = exercise1.returnDocData()
                    
                    //User was created successfully, now store first and last name in new "document" in firestore
                    let db = Firestore.firestore()
                    db.collection("users").document(userID).collection("Exercises").document(dateEaten).setData(docData) { (error) in
                            if error != nil {
                                self.showError("Error in saving user data")
                            }
                        
                        }
                    //Save to Firebase realtime database
                    var ref: DatabaseReference!

                    ref = Database.database().reference()
                    ref.child("Users").child(userID).child("Exercises").child(dateEaten).updateChildValues(docData)
                    { (error, databaserefval)  in
                    if error != nil {
                        self.showError("Error in saving user realtime data")
                    }
                    }
                    //save Data locally to Core Data
                    /*
                    let mealDataPoint = MealDataPoint(context: self.container.viewContext)
                    mealDataPoint.dateEaten = meal1.dateEaten
                    mealDataPoint.foodContent = meal1.foodContent
                    mealDataPoint.location = meal1.location
                    mealDataPoint.mealSize = meal1.mealSize
                    mealDataPoint.timeEntered = meal1.timeEntered
                    self.saveContext()
 */
        }
    }
    
    
    func getCurrentStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
     //   formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let stringDate = formatter.string(from: yourDate!)
        return stringDate
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 */

}

 
