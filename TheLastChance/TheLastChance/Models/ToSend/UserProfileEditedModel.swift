//
//  UserProfileEditedModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 16.12.2024.
//

import Foundation

final class UserProfileEditedModel {
    var login: String = ""
    var username: String = ""
    var contacts: String = ""
    var userImage: Data?
    var backgroundImage: Data?
    func checkData() -> Bool {
        return !username.isEmpty && !contacts.isEmpty
    }
}
