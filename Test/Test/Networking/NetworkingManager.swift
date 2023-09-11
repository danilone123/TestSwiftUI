//
//  NetworkingManager.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import Foundation

fileprivate enum Constant {
    static let token = "Q6HGxKspODNxkOCsOvc2oCX0VfGUE6LXMR0xd5wXxt7MeZbDxM17ihAZ"
}

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
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Constant.token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw PError.invalidData
        }
    }
}



