//
//  CatalogItemCell.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class CatalogItemCell: UITableViewCell {

    @IBOutlet var cellBackView: UIView!
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var priceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minusButton.backConfigure()
        plusButton.backConfigure()
        priceButton.backConfigure()
        
        itemImage.contentMode = .scaleAspectFill
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 10
        
        cellBackView.backConfigure()

    }

}
