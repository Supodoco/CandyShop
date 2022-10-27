//
//  CartDeliveryCell.swift
//  CandyShop
//
//  Created by Supodoco on 27.10.2022.
//

import UIKit

class CartDeliveryCell: UITableViewCell {

    @IBOutlet var cellBackView: UIView!
    @IBOutlet var leadingLabel: UILabel!
    @IBOutlet var trailingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackView.layer.cornerRadius = 10

    }

    
}
