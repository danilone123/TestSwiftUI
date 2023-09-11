//
//  PexelRepository.swift
//  Test
//
//  Created by danny on 11/09/2023.
//

protocol RepositoryProtocol {
    func getVideos() async -> [Video]?
}

class PexelRepository: RepositoryProtocol {
    fileprivate enum Constant {
        static let url = "https://api.pexels.com/videos/popular?per_page=10"
    }
    
    let networking: NetworkingProtocol
    let coreDataManage = CoreDataManager()
    
    init(networking: NetworkingProtocol = APIManager()) {
        self.networking = networking
    }
    
    func getVideos() async -> [Video]? {
        var pexelVideos = coreDataManage.fetchVideos() ?? []
        if pexelVideos.isEmpty {
            let videos: PexelVideos? = try? await networking.doRequest(endPoint: Constant.url)
            coreDataManage.addVideos(videos?.videos)
            pexelVideos = coreDataManage.fetchVideos() ?? []
        }
        return pexelVideos
    }
}
