//
//  UserProfileModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

class UserProfileModel {
    var userId: String = ""
    var username: String = ""
    var contacts: String = ""
    var userImage: Data?
    var backgroundImage: Data?
    func setup(userId: String, username: String, contacts: String, userImage: String, backgroundImage: String) {
        self.userId = userId
        self.username = username
        self.contacts = contacts
        if !userImage.isEmpty {
            self.userImage = Data(base64Encoded: userImage, options: .ignoreUnknownCharacters)
        }
        if !backgroundImage.isEmpty {
            self.backgroundImage = Data(base64Encoded: backgroundImage, options: .ignoreUnknownCharacters)
        }
    }
    func setup(userId: String, username: String, contacts: String, userImage: Data?, backgroundImage: Data?) {
        self.userId = userId
        self.username = username
        self.contacts = contacts
        self.userImage = userImage
        self.backgroundImage = backgroundImage
    }
    func setup(userId: String, json: JSON.UserProfile) {
        self.userId = json.userId
        self.username = json.username
        self.contacts = json.contacts
        if !json.userImage.isEmpty {
            self.userImage = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
        }
        if !json.backgroundImage.isEmpty {
            self.backgroundImage = Data(base64Encoded: json.backgroundImage, options: .ignoreUnknownCharacters)
        }
    }
}
