//
//  UserProfileModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

final class UserProfileModel {
    var userId: String
    var username: String
    var contacts: String
    var userImage: Data?
    var backgroundImage: Data?
    init(userId: String, username: String, contacts: String, userImage: String, backgroundImage: String) {
        self.userId = userId
        self.username = username
        self.contacts = contacts
        self.userImage = Data(base64Encoded: userImage, options: .ignoreUnknownCharacters)
        self.backgroundImage = Data(base64Encoded: backgroundImage, options: .ignoreUnknownCharacters)
    }
    init(userId: String, json: JSON.UserProfile) {
        self.userId = json.userId
        self.username = json.username
        self.contacts = json.contacts
        self.userImage = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
        self.backgroundImage = Data(base64Encoded: json.backgroundImage, options: .ignoreUnknownCharacters)
    }
}
