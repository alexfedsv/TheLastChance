//
//  NetworkManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkManager: NetworkService, NetworkProtocol {

    func getUserProfile(userId: Int, completion: @escaping (Result<JSON.UserProfile, NetworkError>) -> Void) {
        let parameters: [String: String] = [:]
        guard let request = createRequest(parameters: parameters, funcAPIs: APIfunc.test.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
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
    func getPets(userId: Int, completion: @escaping (Result<JSON.PetIds, NetworkError>) -> Void) {
        let parameters: [String: String] = [:]
        guard let request = createRequest(parameters: parameters, funcAPIs: APIfunc.test.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
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
    func getPetProfile(petId: Int, completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
        let parameters: [String: String] = [:]
        guard let request = createRequest(parameters: parameters, funcAPIs: APIfunc.test.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
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
        let parameters: [String: String] = [:]
        guard let request = createRequest(parameters: parameters, funcAPIs: APIfunc.test.rawValue) else {
            let error: NetworkError = .invalidRequest(atFunc: #function)
            completion(.failure(error))
            return
        }
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
}
