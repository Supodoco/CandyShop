//
//  FavoritesViewController.swift
//  CandyShop
//
//  Created by Supodoco on 28.10.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    private let data = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.separatorStyle = .none

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow else { return }
        detailVC?.cellData = data.favorites[indexPath.row]
    }
    
    @objc private func buyButtonTapped(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        print(indexPath.row)
        
    }
    @objc private func changeFavorite(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        print(indexPath.row)
//         data.changeFavorite(id:)
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         data.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cells.catalog.rawValue,
            for: indexPath
        ) as? CatalogItemCell else { return UITableViewCell() }
        
        let currentCake = data.favorites[indexPath.row]
        
        cell.amountLabel.text = currentCake.amount.formatted()
        cell.titleLabel.text = currentCake.title
        cell.itemImage.image = UIImage(named: currentCake.image)
        cell.weightLabel.text = "\(currentCake.weight) г"
        cell.priceButton.setTitle("\(currentCake.price) ₽", for: .normal)
        
        
        addGesture(button: cell.plusButton, action: #selector(buyButtonTapped(sender:)))
        addGesture(button: cell.minusButton, action: #selector(buyButtonTapped(sender:)))
        addGesture(button: cell.priceButton, action: #selector(buyButtonTapped(sender:)))
        
        addGesture(button: cell.favoriteButton, action: #selector(changeFavorite(sender:)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        166
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(
            withIdentifier: Cells.header.rawValue
        ) as? CatalogHeaderCell else { return UIView() }
        header.headerTitle.text = Titles.favorite.rawValue
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
