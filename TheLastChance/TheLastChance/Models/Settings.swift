//
//  Settings.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 22.11.2024.
//

import Foundation

final class Settings {
    static let shared = Settings()
    var userId: String = ""/* {
        get { return UserDefaults.standard.string(forKey: "userId") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "userId") }
    }*/
}
