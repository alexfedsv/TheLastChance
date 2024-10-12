//
//  NetworkMockManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkMockManager: NetworkService, NetworkProtocol {
    func test(completion: @escaping (Result<JSON.Test, NetworkError>) -> Void) {
        print(#file)
        print(#function)
        completion(.failure(.mockServiceUnrealized(atFunc: #function)))
    }
    func getPetProfile(completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        print(#file)
        print(#function)
        completion(.failure(.mockServiceUnrealized(atFunc: #function)))
    }
}
