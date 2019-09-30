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
 
        
        titleLabel.font = .boldSystemFont(ofSize: 25)
        title = "Welcome"

        setUpElements()
    }

    
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        navigationController?.navigationBar.barTintColor = Colors.tableViewBackgroundColor.color
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    //    let attrs = [
      //      NSAttributedString.Key.foregroundColor: UIColor.red,
            //NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
   //     ]
        
   //     UINavigationBar.appearance().titleTextAttributes = attrs
        self.navigationItem.title = "Welcome"

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

