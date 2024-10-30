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
    init(username: String, contacts: String) {
        self.username = username
        self.contacts = contacts
    }
    init(json: JSON.UserProfile) {
        self.username = json.username
        self.contacts = json.contacts
    }
}
