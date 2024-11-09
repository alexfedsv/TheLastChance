//
//  DataManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getUserProfile(userId: Int, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void)
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void)
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void)
}

class DataManager: DataManagerProtocol {
    enum DataSource {
        case net
        case mock
    }
    static let shared = DataManager()
    var dataSource: DataSource = .mock
    var networkServiceProtocol: NetworkProtocol

    init() {
        switch dataSource {
        case .net:
            self.networkServiceProtocol = NetworkManager()
        case .mock:
            self.networkServiceProtocol = NetworkMockManager()
        }
    }
    func getUserProfile(userId: Int, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        networkServiceProtocol.getUserProfile(userId: userId) { result in
            completion(result)
        }
    }
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        networkServiceProtocol.getPets(userId: userId) { result in
            completion(result)
        }
    }
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        networkServiceProtocol.getPetProfile(petId: petId) { result in
            completion(result)
        }
    }
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        networkServiceProtocol.getServices { result in
            completion(result)
        }
    }
}
