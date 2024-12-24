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
    var words: [String] = []
    var minPrice: Int = 0
    var maxPrice: Int = 0
    var servicesFiltered: [ServiceModel] = []
    func checkData() -> Bool {
        return minPrice <= maxPrice
    }
    func rulesCounter() -> Int {
        return words.count + (checkData() ? 1 : 0)
    }
    func priceRole() -> String {
        return String("\(minPrice)-\(maxPrice) руб.")
    }
}
