//
//  VideosViewModel.swift
//  Test
//
//  Created by danny on 09/09/2023.
//

import Foundation

class VideosViewModel: ObservableObject {
    private let repository = PexelRepository()
    @Published var pexelVideos: [Video]?
    @Published var isLoading = false
    
    func getVideos() async  {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        sleep(8)
        let pexelV = await repository.getVideos()
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.pexelVideos = pexelV
        }
        
    }
}
