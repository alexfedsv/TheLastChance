//
//  LoginModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 25.12.2024.
//

import Foundation

final class LoginModel {
    var login: String = ""
    var password: String = ""
    func checkData() -> Bool {
        return password.count >= 6 && login.count >= 5
    }
}
