//
//  UserService.swift
//  PontzerDemoTommyTilton
//
//  Created by Thomas Tilton on 9/6/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserService {
    static func posts(for user: User, completion: @escaping ([Post]) -> Void) {
        var ref: DatabaseRefence!
        let ref = Database.database().reference()
        
    }
}

