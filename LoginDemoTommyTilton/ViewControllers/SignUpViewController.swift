//
//  SignUpViewController.swift
//  LoginDemoTommyTilton
//
//  Created by Thomas Tilton on 8/24/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    //Mainstoryboard elements
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    //texfield delegattre
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        //textfield delegate
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        title = "Sign Up"
    }
    //validation method - check fields and validate data is correct. if everything correct return nil, otherwise returns error message. send error message to label and show it
    func validateFields() -> String? {
        
        
        //FIND REGULAR EXPRESSION FOR CHECKING EMAIL FORMAT
        
        //Check that all fields filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        //Check if Duke email
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if !(email!.contains("@duke.edu")) {
            return "Please give valid university address."
        }
        //Check if password is secure - calls method in utilities that confirms it's atleast 8 chacters, has special character
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isn't secure enough
            return "Please ensure password is atleast 8 characters, contains a special character, and a number."
        }
        //do email check!
        
        return nil
    }
    //IB Action Methods
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate the fields
        let error = validateFields()
        if error != nil {
            //there was an error, something wrong with fields, show error message
            showError(error!)

        }
        else {
            
            //create clean versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    //if err = err then error, not nil
                    self.showError("Error creating user")
                }
                else {
                    //User was created successfully, now store first and last name in new "document" in firestore
                    let uid = result!.user.uid
                    let docData: [String: Any] = ["firstname":firstName, "lastname":lastName, "uid":uid,
                                                  "email":email]
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).setData(docData)
                   
                    //Save user in Realtime Database
                    var ref: DatabaseReference!

                        ref = Database.database().reference()
                        ref.child("Users").child(uid).setValue(docData)
                        { (error, databaserefval)  in
                        if error != nil {
                            self.showError("Error in saving user realtime data")
                        }
                    
                        }
                    
              //      self.transitionToHome()
                    /*
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
                    let vc = UINavigationController(rootViewController: nav)
 */
 //self.addChild(vc)
                    
                }
            }
            self.performSegue(withIdentifier: "Seguevi", sender: nil)
            
        }
    }
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
 

        
        /* THIS WORKEDDDD 9/15/19
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
         let vc = UINavigationController(rootViewController: controller)
         self.present(vc, animated: true, completion: nil)
*/
        /*
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            //maybe should put rootviewcontroller assignment here.
            navigationController?.pushViewController(vc, animated: true)
        }
 */

    
    
    //textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
