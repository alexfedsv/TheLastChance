//
//  NetworkMockManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkMockManager: NetworkService, NetworkProtocol {
    
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
            if let pet = MockPets.shared.pets.first(where: { $0.petId == petId }) {
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
}
