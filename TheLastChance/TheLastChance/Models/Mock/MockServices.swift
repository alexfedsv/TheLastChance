//
//  MockServices.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 31.10.2024.
//

import Foundation

final class MockServices {
    static let shared = MockServices()
    private init() {}
    
    var services: [JSON.Service] = [
        JSON.Service(role: "master",
                              serviceId: "1",
                              userId: "1",
                              title: "Ищу гулятеля со змеей",
                              description: "Требуется дважды в день выгуливать змею Ларису за щедрое вознагрождение.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[0]),
                              petIds: ["1", "2"], price: 0),
        JSON.Service(role: "master",
                              serviceId: "2",
                              userId: "2",
                              title: "Няня для черепахи!",
                              description: "Срочно нуна няня для черепахи.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[1]),
                              petIds: ["3"], price: 100),
        JSON.Service(role: "slave",
                              serviceId: "3",
                              userId: "3",
                              title: "Собакоситер",
                              description: "Требуется ситер для собаки.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[2]),
                              petIds: ["4", "5", "6"], price: 50),
        JSON.Service(role: "master",
                              serviceId: "4",
                              userId: "4",
                              title: "Перевезти кошку",
                              description: "Срочно перевезти кошку из Махачкалы в Москву!",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[3]),
                              petIds: ["3"], price: 430),
        JSON.Service(role: "master",
                              serviceId: "5",
                              userId: "5",
                              title: "Профессиональный гладетель кошки",
                              description: "Ищу человека с нежными руками для глажения кошки",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[4]),
                              petIds: ["5", "2"], price: 0),
        JSON.Service(role: "master",
                              serviceId: "6",
                              userId: "6",
                              title: "Сиделка для больной собаки",
                              description: "Нужна опытная сиделка для больной собаки",
                              userImage:  MockImageHelper.getImageBase64String(imageName: MockUser.avatars[5]),
                              petIds: ["1", "2"], price: 55)
    ]
}
