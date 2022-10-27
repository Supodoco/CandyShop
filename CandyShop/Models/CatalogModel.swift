//
//  CatalogModel.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//
import Foundation

struct CatalogModel {
    let id = UUID()
    let image: String
    let title: String
    let weight: Int
    let price: Int
    var amount: Int
    let description: String
    let sales: Bool
    
    static func getCatalog() -> [CatalogModel] {
        [
            CatalogModel(
                image: "img2",
                title: "Napoleon",
                weight: 1300,
                price: 17800,
                amount: 0,
                description: "",
                sales: true),
            CatalogModel(
                image: "img3",
                title: "Napoleon",
                weight: 1300,
                price: 1780,
                amount: 0,
                description: "",
                sales: false),
            CatalogModel(
                image: "img4",
                title: "Napoleon",
                weight: 1300,
                price: 1780,
                amount: 0,
                description: "",
                sales: false),
            CatalogModel(
                image: "img5",
                title: "Napoleon",
                weight: 1300,
                price: 1780,
                amount: 0,
                description: "",
                sales: false),
            CatalogModel(
                image: "img1",
                title: "Dabosh",
                weight: 2300,
                price: 3120,
                amount: 99,
                description: "",
                sales: false),
            CatalogModel(
                image: "img2",
                title: "Pancake",
                weight: 3200,
                price: 3620,
                amount: 12,
                description: "",
                sales: false)
        ]
    }
}
