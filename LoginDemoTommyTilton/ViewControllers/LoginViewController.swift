//
//  LoginViewController.swift
//  LoginDemoTommyTilton
//
//  Created by Thomas Tilton on 8/24/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    //IB Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    //IB Method
    @IBAction func loginTapped(_ sender: Any) {
        
        //TODO: Validate text fields - make sure all full - use same as sign in view controller
        //validate the fields
        let error = validateFields()
        if error != nil {
            //there was an error, something wrong with fields, show error message
            showError(error!)
            
        }
        else {
        //create clean versions of email and password
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Signing in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                self.transitionToHome()
            }
        }
        
    }
    }
    
    func transitionToHome() {
   /* //Option 1
    let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
 */
   
        //option2
         if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            //maybe should put rootviewcontroller assignment here.
            navigationController?.pushViewController(vc, animated: true)
        }
 

    }
    
    func validateFields() -> String? {
        
        
        //FIND REGULAR EXPRESSION FOR CHECKING EMAIL FORMAT
        
        //Check that all fields filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    
}
