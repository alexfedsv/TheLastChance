//
//  MockAuth.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 30.11.2024.
//

import Foundation

final class MockAuth {
    static let shared = MockAuth()
    final class Auth {
        var userId: String
        var login: String
        var password: String
        init(userId: String, login: String, password: String) {
            self.userId = userId
            self.login = login
            self.password = password
        }
    }
    var auth: [Auth] = [
        Auth(userId: "1", login: "user1", password: "qwerty"),
        Auth(userId: "2", login: "user2", password: "qwerty"),
        Auth(userId: "3", login: "user3", password: "qwerty"),
        Auth(userId: "4", login: "user4", password: "qwerty"),
        Auth(userId: "5", login: "user5", password: "qwerty"),
        Auth(userId: "6", login: "user6", password: "qwerty"),
        Auth(userId: "7", login: "user7", password: "qwerty"),
        Auth(userId: "8", login: "user8", password: "qwerty"),
        Auth(userId: "9", login: "user9", password: "qwerty"),
        Auth(userId: "10", login: "user10", password: "qwerty"),
        Auth(userId: "11", login: "user11", password: "qwerty"),
        Auth(userId: "12", login: "user12", password: "qwerty"),
        Auth(userId: "13", login: "user13", password: "qwerty"),
        Auth(userId: "14", login: "user14", password: "qwerty"),
        Auth(userId: "15", login: "user15", password: "qwerty"),
        Auth(userId: "16", login: "user16", password: "qwerty"),
        Auth(userId: "17", login: "user17", password: "qwerty"),
    ]
}
