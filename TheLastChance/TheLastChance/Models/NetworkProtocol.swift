//
//  NetworkProtocol.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol NetworkProtocol {
    func test(completion: @escaping (Result<JSON.Test, NetworkError>) -> Void)
    func getPetProfile(completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void)
}
