//
//  GuidoTableViewCell.swift
//  Guidomia
//
//  Created by sonnguyen on 2021-04-15.
//

import UIKit

class GuidoTableViewCell3: UITableViewCell {
    @IBOutlet weak var carbrand: UILabel!
    @IBOutlet weak var carpicture: UIImageView!
    @IBOutlet weak var customerprice: UILabel!
    @IBOutlet weak var prosconsview: UIView!
    @IBOutlet weak var tvpros: UITextView!
    @IBOutlet weak var tvcons: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
