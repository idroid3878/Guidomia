//
//  GuidoTableViewCell2.swift
//  Guidomia
//
//  Created by sonnguyen on 2021-04-16.
//
import UIKit
import QuartzCore

class GuidoTableViewCell2: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var searchboxview: UIView!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchboxview.layer.cornerRadius = 15
        searchboxview.layer.masksToBounds = true
        textfield1.delegate=self
        textfield2.delegate=self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
                switch textField.tag {
                case 0:
                    let  carmake = textField.text!
                    print(carmake)
                case 1:
                    let carmodel = textField.text!
                    print(carmodel)
                default: break
                }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
