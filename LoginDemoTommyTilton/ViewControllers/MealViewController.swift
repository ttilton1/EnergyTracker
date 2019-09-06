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

class MealViewController: UIViewController, UITextFieldDelegate {

    var step: Double = 0.0
    //IBOUTLETS
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var foodContentText: UITextField!
    @IBOutlet weak var mealSizeText: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    
    var createdAt: Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        //text delegations
        self.locationText.delegate = self
        self.foodContentText.delegate = self
        self.mealSizeText.delegate = self


       
    }
    
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
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateTextField.text = dateFormatter.string(from: Date())
        //setup datepicker
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(MealViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateTextField.text = dateFormatter.string(from: sender.date)
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
            let timestamp = NSDate().timeIntervalSince1970
            let userID = Auth.auth().currentUser!.uid
//            let stringDate = getCurrentStringDate()
            let dateEaten = dateTextField.text!
            
            //instantiate Database data array
            let docData: [String: Any] = ["food content":foodContent, "location":location, "meal size":mealSize, "time":dateEaten, "time":timestamp]
            
            //User was created successfully, now store first and last name in new "document" in firestore
            let db = Firestore.firestore()
            db.collection("users").document(userID).collection("Meals").document(dateEaten).setData(docData)
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
