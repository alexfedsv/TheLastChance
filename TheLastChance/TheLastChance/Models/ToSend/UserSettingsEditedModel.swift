//
//  UserSettingsEditedModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 16.12.2024.
//

import Foundation

final class UserSettingsEditedModel {
    var login: String = ""
    var password: String = ""
    var passwordNew: String = ""
    var passwordNewConfirmation: String = ""
    var passwordOld: String = ""
    func checkData() -> Bool {
        if !login.isEmpty {
            return !password.isEmpty
        }
        if !passwordNew.isEmpty {
            return passwordNew == passwordNewConfirmation
        }
        return false
    }
}
