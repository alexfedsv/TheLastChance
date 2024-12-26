//
//  NetworkManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkManager: NetworkProtocol {

    enum HTTPMethod: String {
        case POST
        case GET
        case DELETE
        case PUT
    }
    enum Headers: String {
        case contentLength = "Content-Length"
        case contentType = "Content-Type"
        case path = "application/json"
    }
    private let baseURL: String = "http://83.166.238.38:8081/"
    
    func login(login: String, password: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "username": login,
            "password": password
        ]
        guard let url = URL(string: baseURL + APIfunc.login.rawValue), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Auth.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func registrate(login: String, username: String, contacts: String, password: String, userImageString: String, backgroundImageString: String, completion: @escaping (Result<JSON.Auth, NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "login": login,
            "username": username,
            "contacts": contacts,
            "password": password,
            "user_image_string": userImageString,
            "background_image_string": backgroundImageString
        ]
        guard let url = URL(string: baseURL + APIfunc.registrate.rawValue), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Auth.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 406 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipMedia(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 422 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipText(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getUserProfile(userId: String, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getUserInfo.rawValue + "/" + String(userId)) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.UserProfile.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getPets(userId: String, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getPets.rawValue + "/" + String(userId)) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.PetIds.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getPetProfile(petId: String, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getPetInfo.rawValue + "/" + String(petId)) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.PetProfile.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getServices.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode([JSON.Service].self, from: data)
                        print("[DEBUG][\(#function)]: Получено сервисов: \(jsonObject.count)")
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 404 {
                    completion(.success([]))
                    return
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<JSON.ServiceId, NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "role": serviceModel.role.rawValue,
            "user_id": serviceModel.userId,
            "title": serviceModel.title,
            "description": serviceModel.description,
            "pet_ids": serviceModel.petIds,
            "price": serviceModel.price
        ]
        guard let url = URL(string: baseURL + APIfunc.addService.rawValue + "/\(serviceModel.userId)"), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.ServiceId.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 406 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipMedia(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 422 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipText(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func deleteService(serviceId: String, completion: @escaping (NetworkError?) -> Void) {
        guard let url = URL(string:  baseURL + APIfunc.deleteService.rawValue + "?userID=\(Settings.shared.userId)&serviceID=\(serviceId)") else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(err)
                return
            } else if let response = response as? HTTPURLResponse, let _ = data {
                if response.statusCode == 200 {
                    completion(nil)
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(err)
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(err)
                return
            }
        }.resume()
    }
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<JSON.PetId, NetworkError>) -> Void) {
        let stringBase64 = PhotoHelper.getImageBase64String(imageData: petModel.petAvatar)
        let parameters: [String: Any] = [
            "type_of_animal": petModel.typeOfAnimal,
            "name": petModel.petName,
            "info": petModel.info,
            "avatar": stringBase64
        ]
        guard let url = URL(string: baseURL + APIfunc.addPet.rawValue + "/\(Settings.shared.userId)"), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.PetId.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                    
                } else if response.statusCode == 406 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipMedia(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else if response.statusCode == 422 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.failure(.censorshipText(atFunc: #function)))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func deletePet(petId: String, completion: @escaping (NetworkError?) -> Void) {
        guard let url = URL(string:  baseURL + APIfunc.deletePet.rawValue + "?userID=\(Settings.shared.userId)&petID=\(petId)") else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(err)
                return
            } else if let response = response as? HTTPURLResponse, let _ = data {
                if response.statusCode == 200 {
                    completion(nil)
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(err)
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(err)
                return
            }
        }.resume()
    }
    func editPet(petProfileModel: PetProfileModel, completion: @escaping (NetworkError?) -> Void) {
        let stringBase64 = PhotoHelper.getImageBase64String(imageData: petProfileModel.petAvatar)
        let parameters: [String: Any] = [
            "type_of_animal": petProfileModel.typeOfAnimal,
            "name": petProfileModel.petName,
            "info": petProfileModel.info,
            "avatar": stringBase64
        ]
        guard let url = URL(string:  baseURL + APIfunc.updatePet.rawValue + "?userID=\(Settings.shared.userId)&petID=\(petProfileModel.petId)"), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared

        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(err)
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    completion(nil)
                } else if response.statusCode == 406 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.censorshipMedia(atFunc: #function))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(err)
                        return
                    }
                } else if response.statusCode == 422 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.censorshipText(atFunc: #function))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(err)
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(err)
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(err)
                return
            }
        }.resume()
    }
    func editUserProfile(model: UserProfileEditedModel, completion: @escaping (NetworkError?) -> Void) {
        let userStringBase64 = PhotoHelper.getImageBase64String(imageData: model.userImage)
        let backgroundStringBase64 = PhotoHelper.getImageBase64String(imageData: model.backgroundImage)
        let parameters: [String: Any] = [
            "login": "",
            "old_password": "",
            "new_password": "",
            "username": model.username,
            "contacts": model.contacts,
            "user_image_string": userStringBase64,
            "background_image_string": backgroundStringBase64
        ]
        guard let url = URL(string:  baseURL + APIfunc.updateUser.rawValue + "/\(Settings.shared.userId)"), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared

        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(err)
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    completion(nil)
                } else if response.statusCode == 406 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.censorshipMedia(atFunc: #function))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(err)
                        return
                    }
                } else if response.statusCode == 422 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Err.self, from: data)
                        print("DEBUG[\(#function)]: \(jsonObject.message)")
                        completion(.censorshipText(atFunc: #function))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(err)
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(err)
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(err)
                return
            }
        }.resume()
    }
    func editUserSettings(model: UserSettingsEditedModel, completion: @escaping (NetworkError?) -> Void) {
        
    }
    func getAdvice(typeOfAnimal: String, info: String, completion: @escaping (Result<JSON.Advice, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getAdvice.rawValue + "?animal=\(typeOfAnimal)&prompt=\(info)") else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.Advice.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getWordsForFilter(completion: @escaping (Result<JSON.WordsForFilter, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + APIfunc.getWordsForFilter.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode(JSON.WordsForFilter.self, from: data)
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
    func getFilteredServices(completion: @escaping (Result<[JSON.Service], NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "min_price": FilterModel.shared.minPrice,
            "max_price": FilterModel.shared.maxPrice,
            "animals": FilterModel.shared.words
        ]
        guard let url = URL(string: baseURL + APIfunc.getFilteredServices.rawValue/* + "?query=\"\(FilterModel.shared.query)\""*/), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = body
        request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
        request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR[\(#function)]: \(error.localizedDescription)")
                let err: NetworkError = .knownError(err: error, atFunc: #function)
                completion(.failure(err))
                return
            } else if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONDecoder().decode([JSON.Service].self, from: data)
                        print("DEBUG[\(#function)]: Получено \(jsonObject.count) отфильтрованных сервисов")
                        completion(.success(jsonObject))
                        return
                    } catch {
                        print("ERROR[\(#function)]: Decoding JSON: \(error)")
                        let err: NetworkError = .decodingJSON(err: error, atFunc: #function)
                        completion(.failure(err))
                        return
                    }
                } else {
                    print("ERROR[\(#function)]: Something went wrong, response.statusCode: \(response.statusCode)")
                    let err: NetworkError = .errorStatusCode(statusCode: response.statusCode, atFunc: #function)
                    completion(.failure(err))
                    return
                }
            } else {
                print("ERROR[\(#function)]: Something went wrong")
                let err: NetworkError = .unknownError(atFunc: #function)
                completion(.failure(err))
                return
            }
        }.resume()
    }
}
