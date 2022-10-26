//
//  Extension + UIView.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

extension UIView {
    func backConfigure() {
//        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
    }
}

extension UIView {
    func gradientConfigure() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor(red: 253/255, green: 202/255, blue: 191/255, alpha: 1).cgColor,
            UIColor(red: 249/255, green: 220/255, blue: 179/255, alpha: 1).cgColor
        ]
        self.layer.insertSublayer(gradient, at: 0)
    }
}
