//
//  Singleton.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import Foundation


class DataManager {
    static let shared = DataManager()
    
    let deliveryCost = 300
    let freeDeliveryMinSum = 3300
    
    var sales: [CatalogModel] {
        data.filter { $0.sales }
    }
    var catalog: [CatalogModel] {
        data.filter { !$0.sales }
    }
    var cart: [CatalogModel] {
        data.filter { $0.amount > 0 }
    }
    var cartTotalPrice: Int {
        cart.map { $0.price * $0.amount }.reduce(0, +)
    }

    private var data = CatalogModel.getCatalog()
    
    private init() {}
    
    func clearCart() {
        for (index, _) in data.enumerated() {
            data[index].amount = 0
        }
    }
}

