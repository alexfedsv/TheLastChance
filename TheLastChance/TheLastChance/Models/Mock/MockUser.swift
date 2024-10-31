//
//  MockUser.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

final class MockUser {
    static let shared = MockUser()
    let user: JSON.UserProfile = JSON.UserProfile(username: "Пользователь Пользовович", contacts: "+79455678909", userImage: MockImageHelper.getImageBase64String(imageName: "Mock/user"))
}
