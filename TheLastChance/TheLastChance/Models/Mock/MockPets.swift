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
        JSON.PetProfile(typeOfAnimal: "Кошка", petName: "Мурка", info: "Очень ласковая кошка. Имеет аллергию на мышей.", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat1")),
        JSON.PetProfile(typeOfAnimal: "Кошка", petName: "Маркиза", info: "Дико злая кошка. Имеет аллергию на людей.", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat2")),
        JSON.PetProfile(typeOfAnimal: "Кот", petName: "Гладиатор", info: "Бешеный кот. Ласков когда спит. Плохо пахнет", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/cat3")),
        JSON.PetProfile(typeOfAnimal: "Змея", petName: "Елизавета", info: "Почти не кусает. Кусает очень редко, но всегда с летальным исходом. Быть осторожным. Но вообще она очень милая и ласковая.", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/snake")),
        JSON.PetProfile(typeOfAnimal: "Черепаха", petName: "Танк", info: "Любит молоко..", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/turtle")),
        JSON.PetProfile(typeOfAnimal: "Собака", petName: "Кузя", info: "Собака с развитым любопытством.", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/dog1")),
        JSON.PetProfile(typeOfAnimal: "Собака", petName: "Лизка", info: "У собаки аллергия на других собак. Любит бегать.", petAvatar: MockImageHelper.getImageBase64String(imageName: "Mock/dog2"))
    ]
}
