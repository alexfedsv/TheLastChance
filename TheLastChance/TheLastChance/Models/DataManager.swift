//
//  DataManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func login(login: String, password: String, completion: @escaping (NetworkError?) -> Void)
    func registrate(registrationModel: RegistrationModel, completion: @escaping (NetworkError?) -> Void)
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void)
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: String, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void)
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void)
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<ServiceModel, NetworkError>) -> Void)
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void)
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void)
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
    func login(login: String, password: String, completion: @escaping (NetworkError?) -> Void) {
        self.networkServiceProtocol.login(login: login, password: password) { userIdResult in
            switch userIdResult {
            case .success(let json):
                self.networkServiceProtocol.getUserProfile(userId: json.userId) { userProfileResult in
                    switch userProfileResult {
                    case .success(let userProfile):
                        Settings.shared.userId = json.userId
                        UserHostProfileModel.shared.setup(userId: json.userId, json: userProfile)
                        completion(nil)
                    case .failure(let failure):
                        completion(failure)
                    }
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    func registrate(registrationModel: RegistrationModel, completion: @escaping (NetworkError?) -> Void) {
        self.networkServiceProtocol.registrate(
            login: registrationModel.login,
            username: registrationModel.username,
            contacts: registrationModel.contacts,
            password: registrationModel.password,
            userImageString: PhotoHelper.getImageBase64String(imageData: registrationModel.userImage),
            backgroundImageString: PhotoHelper.getImageBase64String(imageData: registrationModel.backgroundImage)) { result in
                switch result {
                case .success(let json):
                    UserHostProfileModel.shared.userId = json.userId
                    UserHostProfileModel.shared.username = registrationModel.username
                    UserHostProfileModel.shared.contacts = registrationModel.contacts
                    UserHostProfileModel.shared.userImage = registrationModel.userImage
                    UserHostProfileModel.shared.backgroundImage = registrationModel.backgroundImage
                    completion(nil)
                case .failure(let failure):
                    completion(failure)
                }
            }
    }
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        networkServiceProtocol.getUserProfile(userId: userId) { result in
            completion(result)
        }
    }
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        networkServiceProtocol.getPets(userId: userId) { result in
            completion(result)
        }
    }
    func getPetProfile(petId: String, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void) {
        networkServiceProtocol.getPetProfile(petId: petId) { result in
            switch result {
            case .success(let success):
                let petProfileModel = PetProfileModel(petId: petId, json: success)
                completion(.success(petProfileModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        networkServiceProtocol.getServices { result in
            completion(result)
        }
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<ServiceModel, NetworkError>) -> Void) {
        networkServiceProtocol.addService(serviceModel: serviceModel) { result in
            switch result {
            case .success(let success):
                var serviceModelCreated: ServiceModel = serviceModel
                serviceModelCreated.serviceId = success
                completion(.success(serviceModelCreated))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void) {
        networkServiceProtocol.addPet(petModel: petModel) { result in
            switch result {
            case .success(let success):
                var petModelCreated: PetProfileModel = petModel
                petModelCreated.petId = success
                completion(.success(petModelCreated))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void) {
    }
}
