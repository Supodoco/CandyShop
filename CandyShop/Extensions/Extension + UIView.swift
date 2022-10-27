//
//  Extension + UIView.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

extension UIView {
    func backConfigure() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
    }
}

