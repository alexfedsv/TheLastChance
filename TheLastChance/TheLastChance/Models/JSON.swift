//
//  JSON.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

struct JSON {
    struct Test: Codable {
        var test: String?
        private enum CodingKeys: String, CodingKey {
            case test = "test"
        }
    }
    struct PetProfile: Codable {
        var typeOfAnimal: String
        var petBreed: String
        var petName: String
        private enum CodingKeys: String, CodingKey {
            case typeOfAnimal = "type_of_animal"
            case petBreed = "breed"
            case petName = "name"
        }
    }
}
