//
//  ServicesModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import Foundation

final class ServicesModel {
    var userId: Int
    var title: String
    var description: String
    init(userId: Int, title: String, description: String) {
        self.userId = userId
        self.title = title
        self.description = description
    }
    init(json: JSON.Service) {
        self.userId = json.userId
        self.title = json.title
        self.description = json.description
    }
    
}
