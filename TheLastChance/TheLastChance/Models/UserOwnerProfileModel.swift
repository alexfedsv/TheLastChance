//
//  UserOwnerProfileModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 09.11.2024.
//

import Foundation

final class UserOwnerProfileModel {
    static let shared = UserOwnerProfileModel()
    var username: String = ""
    var contacts: String = ""
    var userImage: Data?
    private init() { }
    func setup(json: JSON.UserProfile) {
        self.username = json.username
        self.contacts = json.contacts
        self.userImage = Data(base64Encoded: json.userImage, options: .ignoreUnknownCharacters)
    }
}
