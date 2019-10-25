//
//  MoodsViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/19/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth

class MoodsViewController: UIViewController {

    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var SubmitMood: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        

        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        navigationItem.hidesBackButton = true
        Utilities.styleFilledButton(SubmitMood)
        Utilities.styleHollowButton(cancelButton)
        errorLabel.alpha = 0
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sliderLabel.text = "\(String(Int(sender.value)))"
    }
    @IBAction func submitPressed(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        let timeEntered = getCurrentStringDate()
        
        let ret: [String: Any] = ["mood value": sliderLabel.text!, "time": timeEntered]
        let db = Firestore.firestore()
        db.collection("users").document(userID).collection("Moods").document(timeEntered).setData(ret) { (error) in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            }
            if error != nil {
                self.showError("Error in saving user data")
            }
            
        }
        //send to realtime
        let docData: [String: String] = [timeEntered: sliderLabel.text!]
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Users").child(userID).child("Moods").updateChildValues(docData)
        { (error, databaserefval)  in
        if error != nil {
            self.showError("Error in saving user realtime data")
        }
        }

    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
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

}
