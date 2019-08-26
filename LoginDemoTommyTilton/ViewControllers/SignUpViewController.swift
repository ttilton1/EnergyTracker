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

class SignUpViewController: UIViewController {

    //Mainstoryboard elements
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
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
                    let docData: [String: Any] = ["firstname":firstName, "lastname":lastName, "uid":uid]
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).setData(docData)
                //   db.collection("users").document(result!.user.uid.set)  Auth.auth().currentUser!.uid
                   // db.collection("users").document( set(result!.user.uid))
                    
                    /* //Old way, no way of setting Document ID
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]) { (error) in
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    */
                    //transition to homescreen
                    self.transitionToHome()
                    
                }
            }
            
        }
    }
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
      /* //TUTORIAL Way
    let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        */ //newway
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
         let vc = UINavigationController(rootViewController: controller)
         self.present(vc, animated: true, completion: nil)

        /*
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            //maybe should put rootviewcontroller assignment here.
            navigationController?.pushViewController(vc, animated: true)
        }
 */

    }
    
}
