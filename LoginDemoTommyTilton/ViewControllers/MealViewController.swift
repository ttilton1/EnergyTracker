//
//  MealViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/26/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import CoreData

class MealViewController: UIViewController, UITextFieldDelegate {
    
    
    //IBOUTLETS
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var foodContentText: UITextField!
    @IBOutlet weak var mealSizeText: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    //variables
    var step: Double = 0.0
    //hacking with swift coredata
    var container: NSPersistentContainer!
    var mealDataPoints = [MealDataPoint]()
    
    /*
    //persistence manager for coredata to save meal
    let persistenceManager: PersistenceManager
    init(persistenceManager: PersistenceManager){
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 */
    

    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        //text delegations
        self.locationText.delegate = self
        self.foodContentText.delegate = self
        self.mealSizeText.delegate = self
        //coredata persistence
        //persistenceManager.
        
        //hackingwihtswift coredata
        container = NSPersistentContainer(name: "PontzerDemoTommyTilton")
        
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        /* probable delete this
        let mealDataPoint = MealDataPoint()
        mealDataPoint.dateEaten = "Woo"
        mealDataPoint.foodContent = "http://www.example.com"
        mealDataPoint.location = "Place"
        mealDataPoint.mealSize = "l"
        mealDataPoint.timeEntered = "time"
    */
        //hackingwithswiftend
    }
    
    
    //hackingwithswift
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    /*
    func loadSavedData() {
        let request = MealDataPoint.createFetchRequest()
        let sort = NSSortDescriptor(key: "dateEaten", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            mealDataPoints = try container.viewContext.fetch(request)
            print("Got \(mealDataPoints.count) commits")
          //  tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    //end hacking with swift
    */
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(locationText)
        Utilities.styleTextField(foodContentText)
        Utilities.styleTextField(mealSizeText)
        Utilities.styleTextField(dateTextField)
        Utilities.styleFilledButton(submitButton)
        
    }
    
    func validateFields() -> String? {
        if locationText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            foodContentText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            mealSizeText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        //autopopulate textfield
  /*      let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(MealViewController.dismissPicker))
        
        dateTextField.inputAccessoryView = toolBar
  */
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //    dateFormatter.dateStyle = DateFormatter.Style.medium
   //     dateFormatter.timeStyle = DateFormatter.Style.medium
        dateTextField.text = dateFormatter.string(from: Date())
        //setup datepicker
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(MealViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateTextField.text = dateFormatter.string(from: sender.date)
        //get it in version we want to store for organization
    }
    /*
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    */
    
    @IBAction func submitPressed(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            //there was an error, something wrong with fields, show error message
            showError(error!)
        }
        else {
            
            //create clean versions of the data
            let location = locationText.text!.trimmingCharacters(in: .newlines)
            let foodContent = foodContentText.text!.trimmingCharacters(in: .newlines)
            let mealSize = mealSizeText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let timeEntered = getCurrentStringDate()
                //NSDate().timeIntervalSince1970
            let userID = Auth.auth().currentUser!.uid

//            let stringDate = getCurrentStringDate()
            let dateEaten = dateTextField.text!
   
            //instantiate meal object
            let meal1 = MealObject(location: location, foodContent: foodContent, mealSize: mealSize, dateEaten: dateEaten, timeEntered: timeEntered)
            
            //instantiate Database data array
            let docData = meal1.returnDocData()
            
            //User was created successfully, now store first and last name in new "document" in firestore
            let db = Firestore.firestore()
            db.collection("users").document(userID).collection("Meals").document(dateEaten).setData(docData) { (error) in
                    if error != nil {
                        self.showError("Error in saving user data")
                    }
                
                }
            //save Data locally to Core Data
            let mealDataPoint = MealDataPoint(context: self.container.viewContext)
            mealDataPoint.dateEaten = meal1.dateEaten
            mealDataPoint.foodContent = meal1.foodContent
            mealDataPoint.location = meal1.location
            mealDataPoint.mealSize = meal1.mealSize
            mealDataPoint.timeEntered = meal1.timeEntered
            self.saveContext()
        
            /*//Old code
            db.collection("users").document(userID).collection("Meals").addDocument(data: ["food content":foodContent, "location":location, "meal size":mealSize, "time":timestamp]) { (error) in
                    if error != nil {
                        //Show error message
                        self.showError("Error saving user data")
                        }
                    }
                */
                //transition to homescreen
            ProfileDataStore.getTodaysSteps { (final) in
                self.step = final
                let doc: [String: Any] = ["steps":final]
                let db = Firestore.firestore()
                let stringYesterday = self.getYesterdayStringDate()
            db.collection("users").document(userID).collection("Steps").document(stringYesterday).setData(doc)
            }
    
    
                self.transitionToHome()
                    
                }
    
        
    } //end submitPressed
    
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)
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
    
    
    func getYesterdayStringDate() -> String {
        
        let startOfYesterday = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        

        
        let myString = formatter.string(from: startOfYesterday) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        //   formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let stringDate = formatter.string(from: yourDate!)
        return stringDate
    }
    //textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
/*
    func getSteps() {
        ProfileDataStore.getTodaysSteps { (final) in
            self.step = final
            self.step = 1.0
        }
    }
 */
    

}
