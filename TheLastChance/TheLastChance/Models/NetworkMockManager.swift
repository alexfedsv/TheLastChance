//
//  NetworkMockManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkMockManager: NetworkProtocol {
    
    func login(login: String, password: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            if let user = MockAuth.shared.auth.first(where: { $0.login == login }) {
                if password == user.password {
                    let login = JSON.Auth(userId: user.userId)
                    completion(.success(login))
                } else {
                    completion(.failure(.wrongPassword(atFunc: #function)))
                }
            } else {
                completion(.failure(.notFound(atFunc: #function)))
            }
        })
    }
    func registrate(login: String, username: String, contacts: String, password: String, userImageString: String, backgroundImageString: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            let userId = String(MockAuth.shared.auth.count)
            MockAuth.shared.auth.append(MockAuth.Auth(userId: userId, login: login, password: password))
            MockUser.shared.users.append(JSON.UserProfile(userId: userId, username: username, contacts: contacts, userImage: userImageString, backgroundImage: backgroundImageString))
            let login = JSON.Auth(userId: userId)
            completion(.success(login))
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            completion(.success(MockPets.shared.petIds))
        })
    }
    func getPetProfile(petId: String, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            if let petId = Int(petId) {
                let pet = MockPets.shared.pets[petId - 1]
                completion(.success(pet))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            let services = MockServices.shared.services
            completion(.success(JSON.Services(services: services)))
        })
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            if let user = MockUser.shared.users.first(where: { $0.userId == serviceModel.userId }) {
                let json = JSON.Services.Service(role: serviceModel.role.rawValue, serviceId: String(MockServices.shared.services.count), userId: serviceModel.userId, title: serviceModel.title, description: serviceModel.description, userImage: user.userImage, petIds: serviceModel.petIds)
                MockServices.shared.services.append(json)
                completion(.success(String(MockServices.shared.services.count)))
            } else {
                completion(.failure(.notFoundMock(atFunc: #function)))
            }
        })
    }
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            let string = PhotoHelper.getImageBase64String(imageData: petModel.petAvatar)
            let json = JSON.PetProfile(petId: String(MockPets.shared.pets.count), typeOfAnimal: petModel.typeOfAnimal, petName: petModel.petName, info: petModel.info, petAvatar: string)
            MockPets.shared.petIds.petIds.append(String(MockPets.shared.petIds.petIds.count))
            MockPets.shared.pets.append(json)
            completion(.success(String(MockPets.shared.petIds.petIds.count)))
        })
    }
    func editPet(petModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void) {
        
    }
}
