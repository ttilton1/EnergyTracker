//
//  ViewController.swift
//  PontzerMetabolics
//
//  Created by Thomas Tilton on 8/13/19.
//  Copyright © 2019 Thomas Tilton. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    var choices = ["Enter a meal", "Activity Data"] //left off here
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Metabolic Data Entry"
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        
    }
    
    //rows stuff
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
        //override - > changing parent class, func is method, called tableView
        //parameters inside method decide what happened
        //tableView is first parameter, the one we will base number of rows off
        //2nd parameter is number of rows of section
        //pictures.count - we want as many cells there are as many pictures
    }
    
    //specialize which row look like. Row is specified at indexPath. section number and row number, 1 section so can just use row number
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemChoice", for: indexPath) //creates new constant cell by dequeuing recycled cell from table, give it identifier which matches what we said in Interface Builder "Picture"
        cell.textLabel?.text = choices[indexPath.row] //gives table cell same as picture name from pictures array, ? shows may or may not be textlabel
        return cell
    }
    
    
    
    
    
    
}

