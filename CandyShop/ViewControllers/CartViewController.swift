//
//  CartViewController.swift
//  CandyShop
//
//  Created by Supodoco on 26.10.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    private let data = DataManager.shared
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableViewOutlet.indexPathForSelectedRow else { return }
        detailVC?.cellData = data.cart[indexPath.row]
    }
    
    @objc private func changeAmountTapped(sender: UITapGestureRecognizer) {
        // minus tag - 1, plus - 2
        // data.changeAmount(id:, calculate:)
        let indexPath = returnIndexPath(for: tableViewOutlet, sender)
        print(sender.view?.tag)
        // ограничить максимальное количество до 20
        // tableViewOutlet.reloadData()
    }
    
    @objc private func clearCartPressed(sender: UIButton) {
        data.clearCart()
        let duration = 0.15
        UIView.animate(withDuration: duration, delay: 0) {
            sender.transform = CGAffineTransform(rotationAngle: .pi/6)
        }
        UIView.animate(withDuration: duration * 2, delay: duration) {
            sender.transform = CGAffineTransform(rotationAngle: -.pi/6)
        }
        UIView.animate(withDuration: duration, delay: duration * 3) {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 4) {
            self.tableViewOutlet.reloadData()
        }
    }
    

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.cart.isEmpty ? 1 : data.cart.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.cart.isEmpty {
            let cell = UITableViewCell()
            let label: UILabel = {
                let label = UILabel()
                label.text = "Ваша корзина пуста"
                label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
                return label
            }()
            cell.backgroundColor = view.backgroundColor
            cell.addSubview(label)
            label.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 + 30, width: 200, height: 50)
            if let confettiImageView = UIImageView.fromGif(
                    frame: CGRect(
                        x: view.frame.width / 2 - 100,
                        y: view.frame.height / 2 - 200,
                        width: 200, height: 200),
                    resourceName: "hungry"
            ) {
                cell.addSubview(confettiImageView)
                confettiImageView.animationDuration = 1.3
                confettiImageView.startAnimating()
            }
            tableView.isScrollEnabled = false
            return cell
        } else if indexPath.row < data.cart.count {
            tableView.isScrollEnabled = true
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cart.rawValue, for: indexPath)
                    as? CartItemCell else { return UITableViewCell() }
            let cellData = data.cart[indexPath.row]
            
            addGesture(button: cell.plusButton, action: #selector(changeAmountTapped(sender:)))
            addGesture(button: cell.minusButton, action: #selector(changeAmountTapped(sender:)))
            
            cell.titleLabel.text = cellData.title
            cell.itemImageView.image = UIImage(named: cellData.image)
            cell.amountLabel.text = cellData.amount.formatted()
            cell.priceLabel.text = String(cellData.amount * cellData.price) + " ₽"
            
            return cell
            
        } else if indexPath.row == data.cart.count {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Cells.delivery.rawValue,
                for: indexPath)
            as? CartDeliveryCell else { return UITableViewCell() }
            cell.cellBackView.backgroundColor = .clear
            cell.leadingLabel.textColor = .black
            cell.trailingLabel.textColor = .black
            cell.leadingLabel.text = "Доставка"
//            cell.trailingLabel.text = data.deliveryCost.formatted() + " ₽"
            // ячейка цена доставки менять значение на 0 ₽,
            // при минимальной сумме заказа
            // data.freeDeliveryMinSum
            // data.deliveryCost
            // кастомизировать
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Cells.delivery.rawValue,
                for: indexPath)
            as? CartDeliveryCell else { return UITableViewCell() }
            cell.cellBackView.backgroundColor = .systemGreen
            cell.leadingLabel.textColor = .white
            cell.trailingLabel.textColor = .white
            cell.leadingLabel.text = "Оформить заказ"
            // ячейка Оформить заказ,
            // в trailingLabel передать общую сумму заказа
            // data.cartTotalPrice
            // data.freeDeliveryMinSum
            // data.deliveryCost
            // кастомизировать
            // добавить addTarget c переходом на OrderViewController
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: Cells.header.rawValue) as? CatalogHeaderCell else { return UIView() }
        header.headerTitle.text = Titles.cart.rawValue
        
        header.clearCartButtonOutlet.addTarget(
            self,
            action: #selector(clearCartPressed(sender:)),
            for: .touchUpInside
        )
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < data.cart.count {
            return 166
        } else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
