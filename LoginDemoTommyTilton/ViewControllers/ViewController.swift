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
  //  @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = .boldSystemFont(ofSize: 18)
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
    @IBAction func signUpPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "Segueiv", sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Segueiii", sender: nil)
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

