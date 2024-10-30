//
//  MockPets.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

final class MockPets {
    static let shared = MockPets()
    private init() {}
    let petIds: JSON.PetIds = JSON.PetIds(petIds: [
            1,
            2,
            3,
            4,
            5,
            6,
            7
    ])
    let pets: [JSON.PetProfile] = [
        JSON.PetProfile(petId: 1, typeOfAnimal: "Кошка", petName: "Мурка", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat1")),
        JSON.PetProfile(petId: 2, typeOfAnimal: "Кошка", petName: "Маркиза", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat2")),
        JSON.PetProfile(petId: 3, typeOfAnimal: "Кот", petName: "Гладиатор", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat3")),
        JSON.PetProfile(petId: 4, typeOfAnimal: "Змея", petName: "Елизавета", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/snake")),
        JSON.PetProfile(petId: 5, typeOfAnimal: "Черепаха", petName: "Танк", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/turtle")),
        JSON.PetProfile(petId: 6, typeOfAnimal: "Собака", petName: "Кузя", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/dog1")),
        JSON.PetProfile(petId: 7, typeOfAnimal: "Собака", petName: "Лизка", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/dog2"))
    ]
}
