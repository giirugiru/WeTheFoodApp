//
//  HomeTableViewCell.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var areaNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
