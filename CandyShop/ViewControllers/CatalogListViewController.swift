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
        let deltaSum = data.freeDeliveryMinSum - data.deliveryCost -  data.cartTotalPrice
        labelDelivery.text = deltaSum > 0
            ? "\(deltaSum) ₽ до бесплатной доставки"
            : "Бесплатная доставка"
        labelTotalSum.text = "\(data.cartTotalPrice) ₽"
    }
    
    private func getCurrentCake(_ indexPath: IndexPath) -> CatalogModel {
        indexPath.section == 0
        ? data.sales[indexPath.row]
        : data.catalog[indexPath.row]
    }
    
    @objc private func buyButtonTapped(sender: UITapGestureRecognizer) {
        guard let indexPath = returnIndexPath(for: tableViewOutlet, sender) else { return }
        print("\(indexPath.section) section")
        print("\(indexPath.row) row")
        print("\(sender.view?.tag) tag")
        
        let currentCake = getCurrentCake(indexPath)
        
        switch sender.view?.tag {
        case 1:
            if currentCake.amount > 0 {
                data.changeAmount(id: currentCake.id, calculate: .minus)
            }
        case 2:
            if currentCake.amount < 20 {
                data.changeAmount(id: currentCake.id, calculate: .plus)
            }
        default:
            data.changeAmount(id: currentCake.id, calculate: .plus)
        }

        tableViewOutlet.reloadData()
        updateLabels()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow else { return }
        if indexPath.section == 0 {
            detailVC?.cellData = data.sales[indexPath.row]
        } else {
            detailVC?.cellData = data.catalog[indexPath.row]
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
    
        if currentCake.amount == 0 {
            cell.priceButton.isHidden = false
        } else {
            cell.priceButton.isHidden = true
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buyButtonTapped(sender:)))
        let gestureTwo = UITapGestureRecognizer(target: self, action: #selector(buyButtonTapped(sender:)))
        let gestureThree = UITapGestureRecognizer(target: self, action: #selector(buyButtonTapped(sender:)))
        cell.priceButton.addGestureRecognizer(gesture)
        cell.minusButton.addGestureRecognizer(gestureTwo)
        cell.plusButton.addGestureRecognizer(gestureThree)
        
        cell.amountLabel.text = currentCake.amount.formatted()
        cell.priceButton.setTitle(currentCake.price.formatted() + " ₽", for: .normal)
        cell.titleLabel.text = currentCake.title
        cell.weightLabel.text = currentCake.weight.formatted() + " g"
        cell.itemImage.image = UIImage(named: currentCake.image)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        166
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: Cells.header.rawValue) as? CatalogHeaderCell else { return UIView() }
        header.headerTitle.text = section == 0
        ? Titles.sales.rawValue
        : Titles.catalog.rawValue
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
