//
//  DataManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func login(loginModel: LoginModel, completion: @escaping (NetworkError?) -> Void)
    func registrate(registrationModel: RegistrationModel, completion: @escaping (NetworkError?) -> Void)
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void)
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void)
    func getPetProfile(petId: String, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void)
    func getServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void)
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<ServiceModel, NetworkError>) -> Void)
    func deleteService(serviceId: String, completion: @escaping (NetworkError?) -> Void)
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void)
    func deletePet(petId: String, completion: @escaping (NetworkError?) -> Void)
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (NetworkError?) -> Void)
    func editUserProfile(model: UserProfileEditedModel, completion: @escaping (NetworkError?) -> Void)
    func editUserSettings(model: UserSettingsEditedModel, completion: @escaping (NetworkError?) -> Void)
    func getAdvice(typeOfAnimal: String, info: String, completion: @escaping (String) -> Void)
    func getWordsForFilter(completion: @escaping ([String]) -> Void)
    func getFilteredServices(completion: @escaping (NetworkError?) -> Void)
}

class DataManager: DataManagerProtocol {
    enum DataSource {
        case net
        case mock
    }
    static let shared = DataManager()
    var dataSource: DataSource = .net
    var networkServiceProtocol: NetworkProtocol

    init() {
        switch dataSource {
        case .net:
            self.networkServiceProtocol = NetworkManager()
        case .mock:
            self.networkServiceProtocol = NetworkMockManager()
        }
    }
    func login(loginModel: LoginModel, completion: @escaping (NetworkError?) -> Void) {
        self.networkServiceProtocol.login(login: loginModel.login, password: loginModel.password) { userIdResult in
            switch userIdResult {
            case .success(let json):
                self.networkServiceProtocol.getUserProfile(userId: json.userId) { userProfileResult in
                    switch userProfileResult {
                    case .success(let userProfile):
                        print("[DEBUG][\(#function)] юзер авторизован с userId: \(json.userId)")
                        Settings.shared.userId = json.userId
                        Settings.shared.login = loginModel.login
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
                    print("[DEBUG][\(#function)] юзер зарегистрирован с userId: \(json.userId)")
                    Settings.shared.userId = json.userId
                    Settings.shared.login = registrationModel.login
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
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print("error")
            }
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
    func getServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void) {
        networkServiceProtocol.getServices { result in
            completion(result)
        }
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<ServiceModel, NetworkError>) -> Void) {
        networkServiceProtocol.addService(serviceModel: serviceModel) { result in
            switch result {
            case .success(let success):
                let serviceModelCreated: ServiceModel = serviceModel
                serviceModelCreated.serviceId = success.serviceId
                completion(.success(serviceModelCreated))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func deleteService(serviceId: String, completion: @escaping (NetworkError?) -> Void) {
        
    }
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<PetProfileModel, NetworkError>) -> Void) {
        networkServiceProtocol.addPet(petModel: petModel) { result in
            switch result {
            case .success(let success):
                let petModelCreated: PetProfileModel = petModel
                petModelCreated.petId = success.petId
                completion(.success(petModelCreated))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func deletePet(petId: String, completion: @escaping (NetworkError?) -> Void) {
        networkServiceProtocol.deletePet(petId: petId) { err in
            completion(err)
        }
    }
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (NetworkError?) -> Void) {
        networkServiceProtocol.editPet(petProfileModel: petProfileModel) { err in
            completion(err)
        }
    }
    func editUserProfile(model: UserProfileEditedModel, completion: @escaping (NetworkError?) -> Void) {
        networkServiceProtocol.editUserProfile(model: model) { err in
            UserHostProfileModel.shared.setup(userId: Settings.shared.userId, username: model.username, contacts: model.contacts, userImage: model.userImage, backgroundImage: model.backgroundImage)
            completion(err)
        }
    }
    func editUserSettings(model: UserSettingsEditedModel, completion: @escaping (NetworkError?) -> Void) {
        
    }
    func getAdvice(typeOfAnimal: String, info: String, completion: @escaping (String) -> Void) {
        networkServiceProtocol.getAdvice(typeOfAnimal: typeOfAnimal, info: info) { result in
            switch result {
            case .success(let success):
                completion(success.advice)
            case .failure(let failure):
                completion("")
            }
        }
    }
    func getWordsForFilter(completion: @escaping ([String]) -> Void) {
        networkServiceProtocol.getWordsForFilter { result in
            switch result {
            case .success(let success):
                var words: [String] = []
                success.words.forEach({ words.append($0) })
                completion(words)
            case .failure(let failure):
                completion([])
            }
        }
    }
    func getFilteredServices(completion: @escaping (NetworkError?) -> Void) {
        networkServiceProtocol.getFilteredServices() { result in
            switch result {
            case .success(let success):
                FilterModel.shared.servicesFiltered = success.map({ ServiceModel(json: $0) })
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
}
