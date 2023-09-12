//
//  TestApp.swift
//  Test
//
//  Created by danny on 07/09/2023.
//

import SwiftUI

@main
struct TestApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            VideosListView()
                .environmentObject(networkMonitor)
        }
    }
}
