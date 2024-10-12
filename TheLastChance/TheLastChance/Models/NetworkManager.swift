//
//  NetworkManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

final class NetworkManager: NetworkService, NetworkProtocol {
    func test(completion: @escaping (Result<JSON.Test, NetworkError>) -> Void) {
        let parameters = [
            "sdf": "0",
            "sfsdf": "1"]
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
                        let jsonObject = try JSONDecoder().decode(JSON.Test.self, from: data)
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
    func getPetProfile(completion: @escaping (Result<JSON.PetProfile, NetworkError>) -> Void) {
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
}
