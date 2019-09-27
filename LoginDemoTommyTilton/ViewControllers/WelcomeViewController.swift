//
//  WelcomeViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/26/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit
import FirebaseAuth
import UserNotifications

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                self.goToHome()
            }
            else {
                self.goToSignUpLogIn()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func goToHome() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! UITableViewController
        /* let vc = UINavigationController(rootViewController: rvc)
         vc.modalPresentationStyle = .overFullScreen
         present(vc, animated: true, completion: nil)*/
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    func goToSignUpLogIn() {
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as UIViewController
        let vc = UINavigationController(rootViewController: controller)
        self.present(vc, animated: true, completion: nil)

 /*
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.viewController) as? ViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        */
    }
    
    



}
