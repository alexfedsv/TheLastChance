//
//  ServiceModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.10.2024.
//

import Foundation

final class ServiceModel {
    enum Mode {
        case master
        case slave
    }
    var mode: Mode = .master
    var userId: Int
    var title: String
    var description: String
    var userImageData: Data?
    var petImageData: Data?
    init(userId: Int, title: String, description: String, userImageData: String, petImageData: String) {
        self.userId = userId
        self.title = title
        self.description = description
        self.userImageData = Data(base64Encoded: userImageData, options: .ignoreUnknownCharacters)
        self.petImageData = Data(base64Encoded: petImageData, options: .ignoreUnknownCharacters)
    }
    init(json: JSON.Services.Service) {
        self.userId = json.userId
        self.title = json.title
        self.description = json.description
        self.userImageData = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
        self.petImageData = Data(base64Encoded: json.petImage, options: .ignoreUnknownCharacters)
    }
    
}
