//
//  TabBar.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        if let itemsCount = tabBar.items?.count {
            (0..<itemsCount).forEach {
                tabBar.items?[$0].selectedImage = tabBar
                    .items?[$0]
                    .selectedImage?
                    .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            }
        }
    }
}
