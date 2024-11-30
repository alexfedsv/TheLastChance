//
//  NetworkMockManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkMockManager: NetworkProtocol {
    
    func login(login: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            if let user = MockAuth.shared.auth.first(where: { $0.login == login }) {
                if password == user.password {
                    completion(.success(user.userId))
                } else {
                    completion(.failure(.wrongPassword(atFunc: #function)))
                }
            } else {
                completion(.failure(.notFound(atFunc: #function)))
            }
        })
    }
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            if let user = MockUser.shared.users.first(where: { $0.userId == userId }) {
                completion(.success(user))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            completion(.success(MockPets.shared.petIds))
        })
    }
    func getPetProfile(petId: String, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if let petId = Int(petId) {
                let pet = MockPets.shared.pets[petId - 1]
                completion(.success(pet))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let services = MockServices.shared.services
            completion(.success(JSON.Services(services: services)))
        })
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if let userIdIndex = Int(serviceModel.userId) {
                let json = JSON.Services.Service(role: serviceModel.role.rawValue, serviceId: String(MockServices.shared.services.count), userId: serviceModel.userId, title: serviceModel.title, description: serviceModel.description, userImage: MockImageHelper.getImageBase64String(imageName: "Mock/Users/user"), petIds: serviceModel.petIds)
                MockServices.shared.services.append(json)
                completion(.success(String(MockServices.shared.services.count)))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if let petIdIndex = Int(petModel.petId) {
                let string = PhotoHelper.getImageBase64String(imageData: petModel.petAvatar)
                let json = JSON.PetProfile(typeOfAnimal: petModel.typeOfAnimal, petName: petModel.petName, info: petModel.info, petAvatar: string)
                MockPets.shared.petIds.petIds.append(String(MockPets.shared.petIds.petIds.count))
                MockPets.shared.pets.append(json)
                completion(.success(String(MockPets.shared.petIds.petIds.count)))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
}
