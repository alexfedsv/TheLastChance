//
//  PetModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class PetProfileModel {
    var petId: String
    var typeOfAnimal: String
    var petName: String
    var info: String
    var petAvatar: Data?
    init(petId: String, typeOfAnimal: String, petName: String, info: String, petAvatar: String) {
        self.petId = petId
        self.typeOfAnimal = typeOfAnimal
        self.petName = petName
        self.info = info
        if !petAvatar.isEmpty {
            self.petAvatar = Data(base64Encoded: petAvatar, options: .ignoreUnknownCharacters)
        }
    }
    init(petId: String, json: JSON.PetProfile) {
        self.petId = petId
        self.typeOfAnimal = json.typeOfAnimal
        self.petName = json.petName
        self.info = json.info
        if !json.petAvatar.isEmpty {
            if let data = Data(base64Encoded: json.petAvatar, options: .ignoreUnknownCharacters) {
                self.petAvatar = data
            } else {
                print("[ERROR][\(#function)]: Wrong Data")
            }
        }
    }
}
