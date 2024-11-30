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
    }
    enum Headers: String {
        case contentLength = "Content-Length"
        case contentType = "Content-Type"
        case path = "application/json"
    }
    private let baseURL: String = "http://83.166.238.38:8081/"
    
    func login(login: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "login": login,
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
                        let jsonObject = try JSONDecoder().decode(String.self, from: data)
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
    func getServices(completion: @escaping (Result<JSON.Services, NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + "") else {
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
                        let jsonObject = try JSONDecoder().decode(JSON.Services.self, from: data)
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
    func addService(serviceModel: ServiceModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let parameters: [String: Any] = [
            "role": serviceModel.role.rawValue,
            "user_id": serviceModel.userId,
            "title": serviceModel.title,
            "description": serviceModel.description,
            "pet_ids": serviceModel.petIds
        ]
        guard let url = URL(string: baseURL + APIfunc.addService.rawValue), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
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
                        let jsonObject = try JSONDecoder().decode(String.self, from: data)
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
    func addPet(petModel: PetProfileModel, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let stringBase64 = PhotoHelper.getImageBase64String(imageData: petModel.petAvatar)
        let parameters: [String: Any] = [
            "typeOfAnimal": petModel.typeOfAnimal,
            "petName": petModel.petName,
            "info": petModel.info,
            "petAvatar": stringBase64
        ]
        guard let url = URL(string: baseURL + APIfunc.addService.rawValue), let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
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
                        let jsonObject = try JSONDecoder().decode(String.self, from: data)
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
