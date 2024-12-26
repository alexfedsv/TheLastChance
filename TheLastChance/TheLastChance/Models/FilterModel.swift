//
//  FilterModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 23.12.2024.
//

import Foundation

final class FilterModel {
    static let shared = FilterModel()
    private init() {}
    var query: String = ""
    var words: [String] = []
    var price: [String] = []
    var minPrice: Int = 0 {
        didSet {
            if checkData() {
                price = []
                price.append(priceRole())
            } else {
                price = []
            }
        }
    }
    var maxPrice: Int = 0 {
        didSet {
            if checkData() {
                price = []
                price.append(priceRole())
            } else {
                price = []
            }
        }
    }
    var servicesFiltered: [ServiceModel] = []
    func checkData() -> Bool {
        return minPrice < maxPrice
    }
    func priceRole() -> String {
        return String("\(minPrice)-\(maxPrice) руб.")
    }
    func reset() {
        words = []
        price = []
        minPrice = 0
        maxPrice = 0
        servicesFiltered = []
    }
}
