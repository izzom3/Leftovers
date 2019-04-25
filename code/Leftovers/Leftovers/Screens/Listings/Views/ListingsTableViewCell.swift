//
//  ListingsTableViewCell.swift
//  Leftovers
//
//  Created by Matthew Izzo on 3/4/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit

class ListingsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var nameString = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemName.text = nameString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
