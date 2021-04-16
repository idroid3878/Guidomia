//
//  GuidoTableViewCell.swift
//  Guidomia
//
//  Created by sonnguyen on 2021-04-15.
//

import UIKit

class GuidoTableViewCell: UITableViewCell {
    @IBOutlet weak var carbrand: UILabel!
    @IBOutlet weak var carpicture: UIImageView!
    @IBOutlet weak var customerprice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
