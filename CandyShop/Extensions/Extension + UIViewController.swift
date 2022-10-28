//
//  Extension + UIViewController.swift
//  CandyShop
//
//  Created by Supodoco on 28.10.2022.
//

import UIKit

extension UIViewController {
    func returnIndexPath(for tableView: UITableView ,_ sender: UITapGestureRecognizer) -> IndexPath? {
        let position = sender.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: position) {
            return indexPath
        } else {
            return nil
        }
    }
    
    func addGesture(button: UIView, action: Selector?) {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: action
        )
        button.addGestureRecognizer(gesture)
    }
}
