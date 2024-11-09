//
//  NetworkService.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

class NetworkService {
/*
    enum HTTPMethod: String {
        case POST
        case GET
    }
    enum Headers: String {
        case contentLength = "Content-Length"
        case contentType = "Content-Type"
        case path = "application/json"
    }
    let baseURL: String = "http://83.166.238.38:8081/"

    func createRequest(parameters: [String : Any], funcAPIs: String, method: HTTPMethod) -> URLRequest? {
        switch method {
        case .POST:
            guard let url = URL(string: baseURL + funcAPIs),
                  let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.setValue("\(body.count)", forHTTPHeaderField: Headers.contentLength.rawValue)
            request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
            return request
        case .GET:
            guard let url = URL(string: baseURL + funcAPIs) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue(Headers.path.rawValue, forHTTPHeaderField: Headers.contentType.rawValue)
            return request
        }
    }*/
}
