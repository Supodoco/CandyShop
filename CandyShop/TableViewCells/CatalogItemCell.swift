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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minusButton.backConfigure()
        plusButton.backConfigure()
        
        itemImage.contentMode = .scaleAspectFill
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 10
        
        cellBackView.backConfigure()
//        cellBackView.backgroundColor = UIColor(
//            red: 254/255,
//            green: 243/255,
//            blue: 223/255,
//            alpha: 1
//        )
//        contentView.backgroundColor = UIColor(red: 249/255, green: 220/255, blue: 179/255, alpha: 1)
    }

}
