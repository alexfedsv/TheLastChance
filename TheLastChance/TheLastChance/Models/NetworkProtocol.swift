//
//  NetworkProtocol.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol NetworkProtocol {
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void)
}
