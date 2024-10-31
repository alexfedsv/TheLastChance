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
    
    let services: [JSON.Services.Service] = [
        JSON.Services.Service(userId: 1, 
                              title: "Ищу гулятеля со змеей",
                              description: "Требуется дважды в день выгуливать змею Ларису за щедрое вознагрождение.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/snake")),
        JSON.Services.Service(userId: 2, 
                              title: "Няня для черепахи!",
                              description: "Срочно нуна няня для черепахи.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/turtle")),
        JSON.Services.Service(userId: 3, 
                              title: "Собакоситер",
                              description: "Требуется ситер для собаки.",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/dog1")),
        JSON.Services.Service(userId: 4, 
                              title: "Перевезти кошку",
                              description: "Срочно перевезти кошку из Махачкалы в Москву!",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/cat1")),
        JSON.Services.Service(userId: 5, 
                              title: "Профессиональный гладетель кошки",
                              description: "Ищу человека с нежными руками для глажения кошки",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/cat2")),
        JSON.Services.Service(userId: 6, 
                              title: "Сиделка для больной собаки",
                              description: "Нужна опытная сиделка для больной собаки",
                              userImage:  MockImageHelper.getImageBase64String(imageName: "Mock/user"),
                              petImage: MockImageHelper.getImageBase64String(imageName: "Mock/dog2"))
    ]
}
