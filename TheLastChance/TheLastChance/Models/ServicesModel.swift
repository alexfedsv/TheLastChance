//
//  ServicesModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 31.10.2024.
//

import Foundation

final class ServicesModel {
    static let shared = ServicesModel()
    private init() {}
    var servicesMaster: [ServiceModel] = []
    var servicesSlave: [ServiceModel] = []
    var isLoaded: Bool = false
}
