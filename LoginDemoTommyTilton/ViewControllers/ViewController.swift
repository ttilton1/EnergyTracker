//
//  ViewController.swift
//  LoginDemoTommyTilton
//
//  Created by Thomas Tilton on 8/24/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                self.switchStoryboard()
            }
        }
        */
        title = "Welcome"
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        /*
         FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
         if user != nil {
         self.switchStoryboard()
         }
         }
 */
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func switchStoryboard() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        /* let vc = UINavigationController(rootViewController: rvc)
         vc.modalPresentationStyle = .overFullScreen
         present(vc, animated: true, completion: nil)*/
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)

        
    }


}

