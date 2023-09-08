//
//  CoreDataManager.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import CoreData

class CoreDataManager {
    // Responsible for preparing a model
    private let container = NSPersistentContainer(name: "PexelVideoModel")
    private var savedEntities: [Video] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in CoreDataManager \(error.localizedDescription)")
            }
        }
    }
    
    func fetchVideos() -> [Video]? {
        let request = NSFetchRequest<Video>(entityName: "Video")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching videos from core data. \(error)")
            return nil
        }
        
        return savedEntities
    }
    
    func save() throws {
        do {
            try container.viewContext.save()
            print("Data saved successfully")
        } catch {
            throw PError.invalidData
        }
    }
    
    func addVideos(_ videos: [VideoResponse]?) {
        videos?.forEach({ pexelVideo in
            let video = Video(context: container.viewContext)
            video.id = Int32(pexelVideo.id)
            video.image = pexelVideo.image
            video.height = pexelVideo.height ?? 0
            video.width = pexelVideo.width ?? 0
            video.url = pexelVideo.url?.absoluteString
            video.duration = pexelVideo.duration ?? 0
            video.userID = Int32(pexelVideo.user?.id ?? 0)
            video.userName = pexelVideo.user?.name
            video.userURL = pexelVideo.user?.url?.absoluteString
            try? save()
        })

        
    }
}
