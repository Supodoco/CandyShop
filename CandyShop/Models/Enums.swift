//
//  Enums.swift
//  Candyies
//
//  Created by Supodoco on 13.09.2022.
//

import Foundation

enum Titles: String {
    case sales = "Акции"
    case catalog = "Каталог"
    case cart = "Корзина"
    case favorite = "Избранное"
}

enum Counter {
    case plus
    case minus
}

enum Cells: String {
    case teammate = "teammateCell"
    case header = "headerCell"
    case catalog = "catalogItemCell"
    case cart = "cartItemCell"
    case delivery = "cartDeliveryCell"
}
