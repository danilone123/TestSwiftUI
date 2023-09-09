//
//  PexelVideos.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import Foundation

struct VideoResponse: Decodable {
    let id: Int
    let width: Double?
    let height: Double?
    let url: URL?
    let image: String?
    let duration: Int?
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
