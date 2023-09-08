//
//  PexelVideos.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import Foundation

/*
 "id": 1093662,
       "width": 1920,
       "height": 1080,
       "url": "https://www.pexels.com/video/water-crashing-over-the-rocks-1093662/",
       "image": "https://images.pexels.com/videos/1093662/free-video-1093662.jpg?fit=crop&w=1200&h=630&auto=compress&cs=tinysrgb",
       "duration": 8,
       "user": {
         "id": 417939,
         "name": "Peter Fowler",
         "url": "https://www.pexels.com/@peter-fowler-417939"
       }
 */

struct VideoResponse: Decodable {
    let id: Int
    let width: Double?
    let height: Double?
    let url: URL?
    let image: String?
    let duration: Double?
    let user: PexelUser?
}

struct PexelVideos: Decodable {
    let videos: [VideoResponse]?
}

struct PexelUser: Decodable {
    let id: Int
    let name: String?
    let url: URL?
}
