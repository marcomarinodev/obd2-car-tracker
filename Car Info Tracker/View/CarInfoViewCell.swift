//
//  CarInfoViewCell.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

class CarInfoViewCell: UITableViewCell {

    @IBOutlet public var infoTitle: UILabel!
    @IBOutlet public var infoValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
