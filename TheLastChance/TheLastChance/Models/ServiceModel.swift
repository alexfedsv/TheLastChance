//
//  ServiceModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import Foundation

final class ServiceModel {
    enum Mode: String {
        case master = "master"
        case slave = "slave"
    }
    var serviceId: String
    var role: Mode = .slave
    var userId: String
    var title: String
    var description: String
    var userImageData: Data?
    var petIds: [String] = []
    var price: Int
    init(role: Mode, serviceId: String, userId: String, title: String, description: String, userImageData: String, petIds: [String], price: Int) {
        self.role = role
        self.serviceId = serviceId
        self.userId = userId
        self.title = title
        self.description = description
        if !userImageData.isEmpty {
            self.userImageData = Data(base64Encoded: userImageData, options: .ignoreUnknownCharacters)
        }
        self.petIds = petIds.map({ $0 })
        self.price = price
    }
    init(json: JSON.Service) {
        self.role = Mode(rawValue: json.role) ?? .master
        self.serviceId = json.serviceId
        self.userId = json.userId
        self.title = json.title
        self.description = json.description
        if !json.userImage.isEmpty {
            self.userImageData = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
        }
        self.petIds = json.petIds.map({ $0 })
        self.price = json.price
    }
    
}
