//
//  PreviewVideo.swift
//  Test
//
//  Created by danny on 14/09/2023.
//

import CoreData

//Struct created in order to be able to see a preview of VideoDetailView
struct PreviewVideo {
    private let container = NSPersistentContainer(name: "PexelVideoModel")
    let video: Video
    
    init() {
        video = Video(context: container.viewContext)
    }
}
