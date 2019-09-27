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

class LoginViewController: UIViewController, UITextFieldDelegate {

    //IB Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        //textfielddelegates
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func setUpElements() {
        
        //hide error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
        title = "Login"
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
                //self.transitionToHome()
              //  self.shouldPerformSegue(withIdentifier: "SeguePlease", sender: nil)
               self.performSegue(withIdentifier: "Seguev", sender: nil)
            }
        }
        
    }
    }
    
    func transitionToHome() {
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        let vc = UINavigationController(rootViewController: nav)
        self.present(vc, animated: true, completion: nil)
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
  //      appDelegate.window?.rootViewController = vc
 /*   //Option 1
    let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
 */ // new way
        
        /* THIS ONE WORKED HERE****************9/15/19
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)
*/
        /*
    let navViewController = storyboard?.instantiateViewController(withIdentifier: "nav2") as? UINavigationController
    view.window?.rootViewController = navViewController
    view.window?.makeKeyAndVisible()
 */
   /*
     
        //option2
         if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController {
            //maybe should put rootviewcontroller assignment here.
            navigationController?.pushViewController(vc, animated: true)
        }
 */
        /*
        UserDefaults.standard.set(true, forKey: "status")
        Switcher.updateRootVC()
*/
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
}
