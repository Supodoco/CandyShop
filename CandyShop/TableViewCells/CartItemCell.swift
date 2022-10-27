//
//  CartItemCell.swift
//  CandyShop
//
//  Created by Supodoco on 26.10.2022.
//

import UIKit

class CartItemCell: UITableViewCell {

    @IBOutlet var cellBackView: UIView!
    
    @IBOutlet var itemImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackView.backConfigure()
        minusButton.backConfigure()
        plusButton.backConfigure()
        
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 10
    }

}
