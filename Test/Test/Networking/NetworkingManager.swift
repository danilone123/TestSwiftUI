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
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw PError.invalidData
        }
    }
}

class PexelRepository: RepositoryProtocol {
    let networking: NetworkingProtocol
    let coreDataManage = CoreDataManager()
    
    
    init(networking: NetworkingProtocol = APIManager()) {
      self.networking = networking
    }
    
    func getVideos() async -> [Video]? {
        var pexelVideos = coreDataManage.fetchVideos() ?? []
        if pexelVideos.isEmpty {
            let videos: PexelVideos? = try? await networking.doRequest(endPoint: "https://api.pexels.com/videos/popular?per_page=10")
            coreDataManage.addVideos(videos?.videos)
            pexelVideos = coreDataManage.fetchVideos() ?? []
        }
        return pexelVideos
    }
}

class VideosViewModel: ObservableObject {
    private let repository = PexelRepository()
    @Published var pexelVideos: [Video]?
    @Published var isLoading = false
    
    //using MainActor in order to be able to update ui on the main thread
    @MainActor func getVideos() async  {
        self.isLoading = true
        let pexelV = await repository.getVideos()
        self.isLoading = false
        self.pexelVideos = pexelV
    }
}

protocol RepositoryProtocol {
    func getVideos() async -> [Video]?
}


enum PError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
}



