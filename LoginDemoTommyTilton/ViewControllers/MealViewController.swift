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

class MealViewController: UIViewController {

    //IBOUTLETS
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var foodContentText: UITextField!
    @IBOutlet weak var mealSizeText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var createdAt: Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

       
    }
    
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(locationText)
        Utilities.styleTextField(foodContentText)
        Utilities.styleTextField(mealSizeText)
        Utilities.styleFilledButton(submitButton)
    }
    
    func validateFields() -> String? {
        if locationText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            foodContentText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            mealSizeText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
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

            //User was created successfully, now store first and last name in new "document" in firestore
            let db = Firestore.firestore()
            
            db.collection("users").document(userID).collection("Meals").addDocument(data: ["food content":foodContent, "location":location, "meal size":mealSize, "time":timestamp]) { (error) in
                    if error != nil {
                        //Show error message
                        self.showError("Error saving user data")
                        }
                    }
                //transition to homescreen
                self.transitionToHome()
                    
                }
    
        
    } //end submitPressed
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)
    }
    

}
