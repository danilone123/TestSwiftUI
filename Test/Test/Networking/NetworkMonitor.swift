//
//  NetworkingMonitor.swift
//  Test
//
//  Created by danny on 12/09/2023.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "queue.monitor")
    @Published var isConnected = true

    init() {
        networkMonitor.pathUpdateHandler = { path in
            Task {
                //main thread
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
