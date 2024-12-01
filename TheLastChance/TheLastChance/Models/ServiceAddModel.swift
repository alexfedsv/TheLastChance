//
//  ServiceAddModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 01.12.2024.
//

import Foundation

final class ServiceAddModel {
    var role: ServiceModel.Mode = .slave
    var title: String = ""
    var description: String = ""
    var petIds: [String] = []
}
