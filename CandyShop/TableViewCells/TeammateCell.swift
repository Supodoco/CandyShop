//
//  TeammateCell.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class TeammateCell: UITableViewCell {

    @IBOutlet var teammateImage: UIImageView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var fullnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teammateImage.layer.cornerRadius = teammateImage.frame.height / 2
    }
}
