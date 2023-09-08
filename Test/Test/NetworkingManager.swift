//
//  NetworkingManager.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import Foundation

protocol NetworkingProtocol {
    func doRequest<T: Decodable>(
        endPoint: String
    ) async throws -> T
}

class APIManager: NetworkingProtocol {
    func doRequest<T: Decodable>(
        endPoint endpoint: String
    ) async throws -> T {
        
        guard let url = URL(string: endpoint) else {
            throw PError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw PError.invalidData
        }
    }
}

class CreateMyOwnRepository {
    
}


enum PError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
}

