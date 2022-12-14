//
//  CatalogListViewController.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class CatalogListViewController: UIViewController {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    let viewTotalSumAndDeliveryCost = UIView()
    let labelDelivery = UILabel()
    let labelTotalSum = UILabel()
    
    private let data = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.separatorStyle = .none
        tableViewOutlet.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        cartLabelConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
        updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow else { return }
        detailVC?.cellData = getCurrentCake(indexPath)
    }
    
    private func cartLabelConfigure() {
        labelDelivery.translatesAutoresizingMaskIntoConstraints = false
        labelTotalSum.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewTotalSumAndDeliveryCost)
        viewTotalSumAndDeliveryCost.addSubview(labelDelivery)
        viewTotalSumAndDeliveryCost.addSubview(labelTotalSum)
        
        viewTotalSumAndDeliveryCost.backgroundColor = .white
        
        let viewHeight: CGFloat = 40
        viewTotalSumAndDeliveryCost.frame = CGRect(
            x: 0,
            y: view.frame.height - viewHeight - (tabBarController?.tabBar.frame.height ?? 0),
            width: view.frame.width,
            height: viewHeight
        )
        
        labelDelivery.font = UIFont.boldSystemFont(ofSize: 14)
        labelDelivery.textColor = .gray

        labelTotalSum.font = UIFont.boldSystemFont(ofSize: 17)
        updateLabels()
        
        NSLayoutConstraint.activate([
            labelDelivery.leadingAnchor.constraint(equalTo: viewTotalSumAndDeliveryCost.leadingAnchor, constant: 16),
            labelDelivery.centerYAnchor.constraint(equalTo: viewTotalSumAndDeliveryCost.centerYAnchor),
            
            labelTotalSum.trailingAnchor.constraint(equalTo: viewTotalSumAndDeliveryCost.trailingAnchor, constant: -16),
            labelTotalSum.centerYAnchor.constraint(equalTo: viewTotalSumAndDeliveryCost.centerYAnchor)
        ])
    }
    
    private func updateLabels() {
        let deltaSum = data.freeDeliveryMinSum - data.cartTotalPrice
        labelDelivery.text = deltaSum > 0
        ? "\(deltaSum) ??? ???? ???????????????????? ????????????????"
        : "???????????????????? ????????????????"
        labelTotalSum.text = data.calculateTotalSum()
        viewTotalSumAndDeliveryCost.isHidden = data.cartTotalPrice == 0
    }
    
    private func getCurrentCake(_ indexPath: IndexPath) -> CatalogModel {
        indexPath.section == 0
        ? data.sales[indexPath.row]
        : data.catalog[indexPath.row]
    }
    
    @objc private func buyButtonTapped(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        
        let currentCake = getCurrentCake(indexPath)
        guard let tag = sender.view?.tag else { return }
        data.calculateAmount(tag: tag, currentCake: currentCake)
        
        tableViewOutlet.reloadRows(at: [indexPath], with: .none)
        updateLabels()
    }
    
    @objc private func changeFavorite(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        
        let currentCake = getCurrentCake(indexPath)
        data.changeFavorite(id: currentCake.id)
        let duration = 0.15
        UIView.animate(withDuration: duration) {
            sender.view?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }
        UIView.animate(withDuration: duration, delay: duration) {
            sender.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) { [unowned self] in
            tableViewOutlet.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension CatalogListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? data.sales.count : data.catalog.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cells.catalog.rawValue,
            for: indexPath) as? CatalogItemCell
        else { return UITableViewCell() }
        
        let currentCake = getCurrentCake(indexPath)
    
        cell.priceButton.isHidden = currentCake.amount == 0 ? false : true
        
        let img = cell.favoriteButton.imageView?.image
        if currentCake.favorite {
            cell.favoriteButton.setImage(
                img?.withTintColor(.red, renderingMode: .alwaysOriginal),
                for: .normal
            )
        } else {
            cell.favoriteButton.setImage(
                img?.withTintColor(.black, renderingMode: .alwaysOriginal),
                for: .normal
            )
        }
        
        addGesture(cell.plusButton, action: #selector(buyButtonTapped(sender:)))
        addGesture(cell.minusButton, action: #selector(buyButtonTapped(sender:)))
        addGesture(cell.priceButton, action: #selector(buyButtonTapped(sender:)))
        
        addGesture(cell.favoriteButton, action: #selector(changeFavorite(sender:)))
        
        cell.amountLabel.text = currentCake.amount.formatted()
        cell.priceButton.setTitle("\(currentCake.price) ???", for: .normal)
        cell.titleLabel.text = currentCake.title
        cell.weightLabel.text = "\(currentCake.weight) ??"
        cell.itemImage.image = UIImage(named: currentCake.image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        166
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: Cells.header.rawValue) as? CatalogHeaderCell else { return UIView() }
        header.headerTitle.text = section == 0
        ? Titles.sales.rawValue
        : Titles.catalog.rawValue
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
