//
//  ActivityDataViewController.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 8/27/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit

class ActivityDataViewController: UIViewController {
    
    @IBOutlet weak var authorizeHealthData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(authorizeHealthData)
        

        // Do any additional setup after loading the view.
    }
    
    //IB Action
    @IBAction func authorizePressed(_ sender: Any) {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
    }
    



}
