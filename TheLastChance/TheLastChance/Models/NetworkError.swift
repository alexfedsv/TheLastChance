//
//  NetworkError.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest(atFunc: String)
    case decodingJSON(err: Error, atFunc: String)
    case knownError(err: Error, atFunc: String)
    case unknownError(atFunc: String)
    case errorStatusCode(statusCode: Int, atFunc: String)
    case mockServiceUnrealized(atFunc: String)

    func message() -> String {
        switch self {
        case .invalidRequest(let atFunc):
            return "[Network Error][Network Layer][at \(atFunc)]: Invalid request"
        case .decodingJSON(let err, let atFunc):
            return "[Network Error][Network Layer][at \(atFunc)]: Error decoding JSON:\n\(err.localizedDescription)"
        case .unknownError(let atFunc):
            return "[Network Error][Network Layer][at \(atFunc)]: Unknown error"
        case .knownError(let err, let atFunc):
            return "[Network Error][Network Layer][at \(atFunc)]: \(err.localizedDescription)"
        case .errorStatusCode(let statusCode, let atFunc):
            return "[Network Error][Network Layer][at \(atFunc)]: Error with status code: \(statusCode)"
        case .mockServiceUnrealized(let atFunc):
            return "[Network Error][Mock Layer][at \(atFunc)]: Request to an unrealized mock service"
        }
    }
}
