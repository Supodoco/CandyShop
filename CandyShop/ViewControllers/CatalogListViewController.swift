//
//  CatalogListViewController.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import UIKit

class CatalogListViewController: UIViewController {
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    private let data = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.separatorStyle = .none


    }
    
    @objc private func buyButtonTapped(sender: UIButton) {
        // price tag - 3 , minus - 1, plus - 2
        // data.changeAmount(id:, calculate:)
        print(sender.tag)
        // ограничить максимальное количество до 20
        // tableViewOutlet.reloadData()
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
        
        let cellData = indexPath.section == 0
        ? data.sales[indexPath.row]
        : data.catalog[indexPath.row]
    
        // cell.priceButton.isHidden = true
        // скрывать кнопку price по нажатию и возвращать при нулевом количестве
        
        cell.priceButton.addTarget(self, action: #selector(buyButtonTapped(sender:)), for: .touchUpInside)
        cell.minusButton.addTarget(self, action: #selector(buyButtonTapped(sender:)), for: .touchUpInside)
        cell.plusButton.addTarget(self, action: #selector(buyButtonTapped(sender:)), for: .touchUpInside)
        
        cell.amountLabel.text = cellData.amount.formatted()
        cell.priceButton.setTitle(cellData.price.formatted() + " ₽", for: .normal)
        cell.titleLabel.text = cellData.title
        cell.weightLabel.text = cellData.weight.formatted() + " g"
        cell.itemImage.image = UIImage(named: cellData.image)

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
