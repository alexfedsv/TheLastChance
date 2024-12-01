//
//  RegistrationModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 01.12.2024.
//

import Foundation

final class RegistrationModel {
    var login: String = ""
    var username: String = ""
    var contacts: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    var userImage: Data?
    var backgroundImage: Data?
    func checkData() -> Bool {
        return password == passwordConfirmation && !login.isEmpty && !username.isEmpty && !contacts.isEmpty
    }
}
