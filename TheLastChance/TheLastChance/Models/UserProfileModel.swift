//
//  UserProfileModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

final class UserProfileModel {
    var username: String
    var contacts: String
    var userImage: Data?
    init(username: String, contacts: String, userImage: String) {
        self.username = username
        self.contacts = contacts
        self.userImage = Data(base64Encoded: userImage, options: .ignoreUnknownCharacters)
    }
    init(json: JSON.UserProfile) {
        self.username = json.username
        self.contacts = json.contacts
        self.userImage = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
    }
}
