//
//  DataManager.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

class DataManager {
    enum DataSource {
        case net
        case mock
    }
    static let shared = DataManager()
    var dataSource: DataSource = .net {
        didSet {
            updateProtocols()
        }
    }
    var networkServiceProtocol: NetworkProtocol

    init() {
        switch dataSource {
        case .net:
            self.networkServiceProtocol = NetworkManager()
        case .mock:
            self.networkServiceProtocol = NetworkMockManager()
        }
    }
    private func updateProtocols() {
        switch dataSource {
        case .net:
            self.networkServiceProtocol = NetworkManager()
        case .mock:
            self.networkServiceProtocol = NetworkMockManager()
        }
    }
}
