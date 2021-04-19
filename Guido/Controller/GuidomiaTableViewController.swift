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
    var selectedRowIndex = -1
    
    var carlist: [Car] = []
    
    var useSequeForDetails: Bool = false

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
                
                //carlist = cars
                carlist.append(contentsOf: cars)
                
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
                        //carlist = cars
                        carlist.append(contentsOf: cars)
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
        carlist.append(Car(consList: [""],customerPrice: 0,make: "",marketPrice: 0,model: "",prosList: [],rating:0))
        carlist.append(Car(consList: [""],customerPrice: 0,make: "",marketPrice: 0,model: "",prosList: [],rating:0))
        
        extractJsonInfo(fromFile: true)

        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(rgb: 0xFC6016) //orange
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.isHidden = false
        
        let barbt: UIButton = UIButton(type: UIButton.ButtonType.custom)
        barbt.setImage(UIImage(named: "rightbarbutton"), for: UIControl.State.normal)
        barbt.addTarget(self, action: #selector(myRightSideBarButtonItemTapped), for: UIControl.Event.touchUpInside)
        let rightbarbt = UIBarButtonItem(customView: barbt)
        
        self.navigationItem.rightBarButtonItem = rightbarbt
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        print("myRightSideBarButtonItemTapped")
        self.performSegue(withIdentifier: "sequeToDetail", sender: self)
    }
    
    //func evenRow(_ row: Int ) -> Bool {
    //    var rowiseven=true
    //    if row % 2 == 0 {
    //        print("\(row) is even number")
    //    } else {
    //        print("\(row) is odd number")
    //        rowiseven=false
    //    }
    //    return rowiseven
    //}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carlist.count + 7 // some more rows to scroll with
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
            
            if indexPath.row > 1 && indexPath.row < carlist.count {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "GuidoCell3", for: indexPath) as! GuidoTableViewCell3
                let current_idx=indexPath.row
                
                let car_cell = carlist[current_idx]
            
                cell2.carbrand.text = car_cell.make + " " + car_cell.model
                cell2.carpicture?.image = UIImage(named: car_cell.model)
                let customerprice=String(car_cell.customerPrice.roundedWithPrefix)

                cell2.customerprice.text = "$" + customerprice
        
                cell2.prosconsview.isHidden = true
        
                return cell2
            }
            else {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "GuidoCell3", for: indexPath) as! GuidoTableViewCell3
                
                cell2.carbrand.text = "Pontiac Fiero"
                cell2.carpicture?.image = UIImage(named: "carpix")

                cell2.customerprice.text = "$500"
            
                cell2.prosconsview.isHidden = true
            
                return cell2
            }
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sequeToDetail") {
            print("")
        }
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.row == 0 {
           return 280 //280
       }
       else if indexPath.row == 1 {
           return 220
       }
       else {
            if indexPath.row == selectedRowIndex {
                return 380
            }
            else {
                self.tableView.cellForRow(at: indexPath)?.contentView.viewWithTag(19)?.isHidden = true
               return 180 //220
            }
           //return UITableView.automaticDimension
       }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 1 {
            print("")
        }
        else {
            if selectedRowIndex != indexPath.row {
                self.tableView.cellForRow(at: indexPath)?.contentView.viewWithTag(19)?.isHidden = false
                // store the currently clicked index
                self.selectedRowIndex = indexPath.row
                
                let cell = self.tableView.cellForRow(at: indexPath)
                let pros_and_cons=cell?.viewWithTag(19)
                let tvpros=pros_and_cons?.viewWithTag(20) as! UITextView
                let tvcons=pros_and_cons?.viewWithTag(21) as! UITextView
                let capheight=(tvpros.font?.capHeight ?? 7) // scale circle to height of text
                let txtAttachment = NSTextAttachment()
                let theimage=UIImage(named: "circle")!
                txtAttachment.image = UIImage(named: "circle")!
                txtAttachment.bounds = CGRect(x: 0, y: 0, width: theimage.size.width/7, height: theimage.size.height/capheight)
                let strWithImage = NSAttributedString(attachment: txtAttachment)
                let pros_string = NSMutableAttributedString(string: "")
                let cons_string = NSMutableAttributedString(string: "")
                tvpros.attributedText = pros_string // init
                tvcons.attributedText = cons_string // init
                
                if indexPath.row > 1 && indexPath.row < carlist.count {
                    let car_cell = carlist[indexPath.row]

                    
                    let prolist = car_cell.prosList
                    prolist.forEach { item in
                        if item != "" {
                            pros_string.append( strWithImage )
                            pros_string.append( NSAttributedString(string: "  "+item+"\n"))
                            tvpros.attributedText = pros_string
                        } else {
                            //print("pro_nil=\(item)")
                        }
                    }
                    
                    let conlist = car_cell.consList
                    conlist.forEach { item in
                        if item != "" {
                            print("con=\(item)")
                            cons_string.append( strWithImage )
                            cons_string.append( NSAttributedString(string: "  "+item+"\n") )
                            tvcons.attributedText = cons_string
                        } else {
                            //print("cons_nil=\(item)")
                        }
                    }
                }
                else {
                    pros_string.append( strWithImage )
                    pros_string.append( NSAttributedString(string: "  Good on gas\n"))
                    tvpros.attributedText = pros_string
                    cons_string.append( strWithImage )
                    cons_string.append( NSAttributedString(string: "  Very bumpy ride\n") )
                    tvcons.attributedText = cons_string
                }

                self.tableView.beginUpdates() // update the height for all cells in table
                self.tableView.endUpdates()
            }
        }
    }
}
