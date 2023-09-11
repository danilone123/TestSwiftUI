//
//  VideosViewModel.swift
//  Test
//
//  Created by danny on 09/09/2023.
//

import Foundation

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
