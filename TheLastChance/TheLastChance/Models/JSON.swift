//
//  JSON.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

struct JSON {
    struct Auth: Codable {
        var userId: String
        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
        }
        
    }
    struct PetIds: Codable {
        var petIds: [String]
        private enum CodingKeys: String, CodingKey {
            case petIds = "pet_ids"
        }
    }
    struct PetProfile: Codable {
        var typeOfAnimal: String
        var petName: String
        var info: String
        var petAvatar: String
        private enum CodingKeys: String, CodingKey {
            case typeOfAnimal = "type_of_animal"
            case petName = "name"
            case info = "info"
            case petAvatar = "avatar"
        }
    }
    struct UserProfile: Codable {
        var userId: String
        var username: String
        var contacts: String
        var userImage: String
        var backgroundImage: String
        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case username = "username"
            case contacts = "contacts"
            case userImage = "user_image"
            case backgroundImage = "background_image"
        }
    }
    struct Services: Codable {
        struct Service: Codable {
            var role: String
            var serviceId: String
            var userId: String
            var title: String
            var description: String
            var userImage: String
            var petIds: [String]
            private enum CodingKeys: String, CodingKey {
                case role = "role"
                case serviceId = "service_id"
                case userId = "user_id"
                case title = "title"
                case description = "description"
                case userImage = "user_image"
                case petIds = "pet_ids"
            }
        }
        var services: [Service]
    }
}
