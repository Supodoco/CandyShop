//
//  DetailViewController.swift
//  CandyShop
//
//  Created by Supodoco on 26.10.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var dismissButtonOutlet: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var cellData: CatalogModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageConfigure()
        
        dismissButtonOutlet.layer.cornerRadius = 10
        
        titleLabel.text = cellData.title
        
        descriptionLabel.text =
        cellData.weight.formatted() + " g · " + cellData.description
        
    }
    
    @IBAction func dismissButtonPressed() {
        dismiss(animated: true)
    }
    
    private func imageConfigure() {
        detailImage.image = UIImage(named: cellData.image)
        detailImage.contentMode = .scaleAspectFill
        detailImage.clipsToBounds = true
    }
}
