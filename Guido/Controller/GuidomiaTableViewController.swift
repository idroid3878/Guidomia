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
        if let path = Bundle.main.path(forResource: "car_list", ofType: "json") {
            do {
                let thetext = try String(contentsOfFile: path, encoding: .utf8)
                print("text=\(thetext)")
                if let data = thetext.data(using: .utf8) {
                    if let cars = try? JSONDecoder().decode([Car].self, from: data)  {
                        carlist = cars
                    }
                    else {
                        readJsonFromStringVar() // fall back to string var
                    }
                }
            } catch let error {
                print("file read unsuccessful: \(error.localizedDescription)")
                readJsonFromStringVar()
            }
        }
        else {
            readJsonFromStringVar()
        }
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
        extractJsonInfo(fromFile: true)
        //readJsonFromTextFile()
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 280
        }
        else {
            return 220 //UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carlist.count + 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "GuidoCell1", for: indexPath) as! GuidoTableViewCell1
             return cell1
        }
        else if indexPath.row == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "GuidoCell2", for: indexPath) as! GuidoTableViewCell2
             return cell2
        }
        else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "GuidomiaCell", for: indexPath) as! GuidoTableViewCell
            if indexPath.row > 1 && indexPath.row < carlist.count + 2 {
            
                let current_idx=indexPath.row-2
                let car_cell = carlist[current_idx]
            
                cell2.carbrand.text = car_cell.make + " " + car_cell.model
                cell2.carpicture?.image = UIImage(named: car_cell.model)
                let customerprice=String(car_cell.customerPrice)

                cell2.customerprice.text = "$" + " " + customerprice
            }
            return cell2
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}
