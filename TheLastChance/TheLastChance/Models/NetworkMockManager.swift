//
//  NetworkMockManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkMockManager: NetworkProtocol {
    
    func getUserProfile(userId: Int, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            completion(.success(MockUser.shared.user))
        })
    }
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            completion(.success(MockPets.shared.petIds))
        })
    }
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let pet = MockPets.shared.pets[petId - 1]
            completion(.success(pet))
        })
    }
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let services = MockServices.shared.services
            completion(.success(JSON.Services(services: services)))
        })
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let json = JSON.Services.Service(role: serviceModel.role.rawValue, serviceId: MockServices.shared.services.count, userId: serviceModel.userId, title: serviceModel.title, description: serviceModel.description, userImage: MockImageHelper.getImageBase64String(imageName: "Mock/user"), petIds: serviceModel.petIds)
            MockServices.shared.services.append(json)
            completion(.success(MockServices.shared.services.count))
        })
    }
}
