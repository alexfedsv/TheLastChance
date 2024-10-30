//
//  PetModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class PetProfileModel {
    var typeOfAnimal: String
    var petName: String
    var petAvatar: Data?
    init(typeOfAnimal: String, petAvatar: String, petName: String) {
        self.typeOfAnimal = typeOfAnimal
        self.petName = petName
        self.petAvatar = Data(base64Encoded: petAvatar, options: .ignoreUnknownCharacters)
    }
    init(json: JSON.PetProfile) {
        self.typeOfAnimal = json.typeOfAnimal
        self.petName = json.petName
        self.petAvatar = Data(base64Encoded: json.petAvatar, options: .ignoreUnknownCharacters)
    }
}
