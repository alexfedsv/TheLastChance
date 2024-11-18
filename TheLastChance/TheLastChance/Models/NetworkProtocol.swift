//
//  NetworkProtocol.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol NetworkProtocol {
    func getUserProfile(userId: Int, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void)
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void)
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void)
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<Int, NetworkError>) -> Void)
}
