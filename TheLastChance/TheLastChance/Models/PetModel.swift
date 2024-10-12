//
//  PetModel.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

class PetModel {
    var typeOfAnimal: String
    var petBreed: String
    var petName: String
    init(typeOfAnimal: String, petBreed: String, petName: String) {
        self.typeOfAnimal = typeOfAnimal
        self.petBreed = petBreed
        self.petName = petName
    }
    init(json: JSON.PetProfile) {
        self.typeOfAnimal = json.typeOfAnimal
        self.petBreed = json.petBreed
        self.petName = json.petName
    }
}
