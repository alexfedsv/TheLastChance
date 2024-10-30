//
//  JSON.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

struct JSON {
    struct PetIds: Codable {
        var petIds: [Int]
        private enum CodingKeys: String, CodingKey {
            case petIds = "pet_ids"
        }
    }
    struct PetProfile: Codable {
        var petId: Int
        var typeOfAnimal: String
        var petName: String
        var petAvatar: String
        private enum CodingKeys: String, CodingKey {
            case petId = "pet_id"
            case typeOfAnimal = "type_of_animal"
            case petName = "name"
            case petAvatar = "avatar"
        }
    }
    struct UserProfile: Codable {
        var username: String
        var contacts: String
        private enum CodingKeys: String, CodingKey {
            case username = "username"
            case contacts = "contacts"
        }
    }
    struct Service: Codable {
        var userId: Int
        var title: String
        var description: String
        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case title = "title"
            case description = "description"
        }
    }
}
