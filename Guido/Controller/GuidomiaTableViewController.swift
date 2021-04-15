//
//  GuidomiaTableViewController.swift
//
//  Created by SonNguyen on 2021-04-15.
//  Copyright © 2021 sonnguyen. All rights reserved.

import UIKit

struct Car: Decodable
{
    let consList: [String]
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let rating: Int
}

class GuidomiaTableViewController: UITableViewController {

    var carlist: [Car] = []

    var jsonText = """
    [{"consList":["Bad direction"],"customerPrice":120000.0,"make":"Land Rover","marketPrice":125000.0,"model":"Range Rover","prosList":["You can go everywhere","Good sound system"],"rating":3},{"consList":["Sometime explode"],"customerPrice":220000.0,"make":"Alpine","marketPrice":225000.0,"model":"Roadster","prosList":["This car is so fast","Jame Bond would love to steal that car","",""],"rating":4},{"consList":["You can heard the engine over children cry at the back","","You may lose this one if you divorce"],"customerPrice":65000.0,"make":"BMW","marketPrice":55900.0,"model":"3300i","prosList":["Your average business man car","Can bring the family home safely","The city must have"],"rating":5},{"consList":["You may lose a wheel","Expensive maintenance"],"customerPrice":95000.0,"make":"Mercedes Benz","marketPrice":85900.0,"model":"GLE coupe","prosList":[],"rating":2}]
    """
    
    func readJsonFromStringVar() {
        if let data = jsonText.data(using: .utf8) {
                
            do {
                guard let cars = try? JSONDecoder().decode([Car].self, from: data) else {
                  print("Error: unable to create cars array, verify json  needed!")
                    return;
                }
                
                carlist = cars
                
                for car in carlist {
                        print("debug car model is \(car.model)")
                        print("debug car make is \(car.make)")
                        print("-----")
                }
            }
        }
    }
    
    func readJsonFromTextFile() -> Void {
        // read file
    }
    
    func extractJsonInfo(fromFile ReadFromFile: Bool) -> Void {
        if ReadFromFile == true {
            readJsonFromTextFile()
        }
        else {
            readJsonFromStringVar()
        }
    }
    
    override func viewDidLoad() {
        extractJsonInfo(fromFile: false)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carlist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuidomiaCell", for: indexPath)

        let car_cell = carlist[indexPath.row]
        cell.textLabel?.text = car_cell.make
        cell.detailTextLabel?.text = car_cell.model
        cell.imageView?.image = UIImage(named: car_cell.model)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}
