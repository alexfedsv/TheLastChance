//
//  NetworkProtocol.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol NetworkProtocol {
    func login(login: String, password: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void)
    func registrate(login: String, username: String, contacts: String, password: String, userImageString: String, backgroundImageString: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void)
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void)
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: String, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void)
    func getServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void)
    func deleteService(serviceId: String, completion: @escaping (NetworkError?) -> Void)
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<JSON.ServiceId, NetworkError>) -> Void)
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<JSON.PetId, NetworkError>) -> Void)
    func deletePet(petId: String, completion: @escaping (NetworkError?) -> Void)
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (NetworkError?) -> Void)
    func editUserProfile(model: UserProfileEditedModel, completion: @escaping (NetworkError?) -> Void)
    func editUserSettings(model: UserSettingsEditedModel, completion: @escaping (NetworkError?) -> Void)
    func getAdvice(typeOfAnimal: String, info: String, completion: @escaping (Result<JSON.Advice, NetworkError>) -> Void)
    func getWordsForFilter(completion: @escaping (Result<JSON.WordsForFilter, NetworkError>) -> Void)
    func getFilteredServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void)
}
