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
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow else { return }
        detailVC?.cellData = data.favorites[indexPath.row]
    }
    
    @objc private func buyButtonTapped(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        
        let currentCake = data.favorites[indexPath.row]
        guard let tag = sender.view?.tag else { return }
        data.calculateAmount(tag: tag, currentCake: currentCake)
        tableViewOutlet.reloadData()
    }
    
    @objc private func changeFavorite(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        
        let currentCake = data.favorites[indexPath.row]
        data.changeFavorite(id: currentCake.id)
        tableViewOutlet.reloadData()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.favorites.count == 0 ? 1 : data.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.favorites.isEmpty {
            let cell = UITableViewCell()
            let label: UILabel = {
                let label = UILabel()
                label.text = "В избранном пусто"
                label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
                return label
            }()
            cell.backgroundColor = view.backgroundColor
            cell.addSubview(label)
            label.textAlignment = .center
            label.frame = CGRect(
                x: view.frame.width / 2 - 100,
                y: view.frame.height / 2 + 30,
                width: 200,
                height: 50
            )
            let image = UIImageView(
                frame:
                    CGRect(
                        x: view.frame.width / 2 - 100,
                        y: view.frame.height / 2 - 200,
                        width: 200,
                        height: 200
                    )
            )
            image.image = UIImage(named: "favorites")
            cell.addSubview(image)
            tableView.isScrollEnabled = false
            return cell
        } else {
            tableView.isScrollEnabled = true
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Cells.catalog.rawValue,
                for: indexPath
            ) as? CatalogItemCell else { return UITableViewCell() }
            
            let currentCake = data.favorites[indexPath.row]
            
            cell.priceButton.isHidden = currentCake.amount == 0 ? false : true
            
            let img = cell.favoriteButton.imageView?.image
            cell.favoriteButton.setImage(
                img?.withTintColor(.red, renderingMode: .alwaysOriginal),
                for: .normal
            )

            cell.amountLabel.text = currentCake.amount.formatted()
            cell.titleLabel.text = currentCake.title
            cell.itemImage.image = UIImage(named: currentCake.image)
            cell.weightLabel.text = "\(currentCake.weight) г"
            cell.priceButton.setTitle("\(currentCake.price) ₽", for: .normal)
            
            
            addGesture(cell.plusButton, action: #selector(buyButtonTapped(sender:)))
            addGesture(cell.minusButton, action: #selector(buyButtonTapped(sender:)))
            addGesture(cell.priceButton, action: #selector(buyButtonTapped(sender:)))
            
            addGesture(cell.favoriteButton, action: #selector(changeFavorite(sender:)))
            
            return cell
        }
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
