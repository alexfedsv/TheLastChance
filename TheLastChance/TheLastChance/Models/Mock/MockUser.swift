//
//  MockUser.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 29.10.2024.
//

import Foundation

final class MockUser {
    static let shared = MockUser()
    let user: JSON.UserProfile = JSON.UserProfile(userId: "0", username: "Пользователь Пользовович", contacts: "+79455678909", userImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/user"), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals"))
    var users: [JSON.UserProfile] = [
        JSON.UserProfile(userId: "1", username: "Роберт Эдвард Ли", contacts: "+79995550001", userImage: MockImageHelper.getImageBase64String(imageName: avatars[0]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "2", username: "Томас Джонатан Джексон", contacts: "+79995550002", userImage: MockImageHelper.getImageBase64String(imageName: avatars[1]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "3", username: "Джеб Стюарт", contacts: "+79995550003", userImage: MockImageHelper.getImageBase64String(imageName: avatars[2]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "4", username: "Джеймс Лонгстрит", contacts: "+79995550004", userImage: MockImageHelper.getImageBase64String(imageName: avatars[3]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "5", username: "Джон Белл Худ", contacts: "+79995550005", userImage: MockImageHelper.getImageBase64String(imageName: avatars[4]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "6", username: "Эдмунд Кирби Смит", contacts: "+79995550006", userImage: MockImageHelper.getImageBase64String(imageName: avatars[5]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "7", username: "Джозеф Эгглстон Джонстон", contacts: "+79995550007", userImage: MockImageHelper.getImageBase64String(imageName: avatars[6]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "8", username: "Пьер Гюстав Тутан де Борегар", contacts: "+79995550008", userImage: MockImageHelper.getImageBase64String(imageName: avatars[7]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "9", username: "Джозеф Рид Андерсон", contacts: "+79995550009", userImage: MockImageHelper.getImageBase64String(imageName: avatars[8]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "10", username: "Фрэнсис Луиза Клейтон", contacts: "+79995550010", userImage: MockImageHelper.getImageBase64String(imageName: avatars[9]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "11", username: "Альберт Сидни Джонстон", contacts: "+79995550011", userImage: MockImageHelper.getImageBase64String(imageName: avatars[10]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "12", username: "Эдвард Джонсон", contacts: "+79995550012", userImage: MockImageHelper.getImageBase64String(imageName: avatars[11]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "13", username: "Мартин Лютер Смит", contacts: "+79995550013", userImage: MockImageHelper.getImageBase64String(imageName: avatars[12]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "14", username: "Джеймс Паттон Андерсон", contacts: "+79995550014", userImage: MockImageHelper.getImageBase64String(imageName: avatars[13]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "15", username: "Генри Хопкинс Сибли", contacts: "+79995550015", userImage: MockImageHelper.getImageBase64String(imageName: avatars[14]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "16", username: "Джефферсон Финис Дэвис", contacts: "+79995550016", userImage: MockImageHelper.getImageBase64String(imageName: avatars[15]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals")),
        JSON.UserProfile(userId: "17", username: "Пользователь Пользовович", contacts: "+79995550017", userImage: MockImageHelper.getImageBase64String(imageName: avatars[16]), backgroundImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/animals"))
    ]
    static let avatars: [String] = [
        "Mock/Users/robert_edward_lee", // 1
        "Mock/Users/stonewall_jackson", // 2
        "Mock/Users/james_ewell_brown_stuart", // 3
        "Mock/Users/james_longstreet", // 4
        "Mock/Users/john_bell_hood", // 5
        "Mock/Users/edmund_kirby_smith", // 6
        "Mock/Users/joseph_johnston", // 7
        "Mock/Users/pgt_beauregard", // 8
        "Mock/Users/joseph_reid_anderson", // 9
        "Mock/Users/frances_louisa_clayton", // 10
        "Mock/Users/as_johnston", // 11
        "Mock/Users/johnson_edward", // 12
        "Mock/Users/martin_luther_smith", // 13
        "Mock/Users/james_patton_anderson", // 14
        "Mock/Users/henry_hopkins_sibley", // 15
        "Mock/Users/president_jefferson_davis", // 16
        "Mock/Users/user" // 17
    ]
}
