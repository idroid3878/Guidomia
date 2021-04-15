//
//  ViewController.swift
//  mycarapp
//
//  Created by SonNguyen on 2021-04-15.
//  Copyright © 2021 sonnguyen. All rights reserved.
//

import UIKit

class ViewController:  UITableViewController {
    
    var carnames = ["Alpine", "LandRover", "Mercedes", "BMW"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carnames.count+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycustomcell", for: indexPath)
        //cell.textlabel1="mercedes"
        return cell
    }
}

