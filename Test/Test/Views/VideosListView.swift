//
//  ContentView.swift
//  Test
//
//  Created by danny on 07/09/2023.
//

import SwiftUI

struct VideosListView: View {
    @StateObject var viewModel = VideosViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.pexelVideos ?? []) { video in
                    VideoCellView(video: video)
                }
                .navigationTitle("Most Popular Videos ")
            }
            .onAppear {
                Task {
                    await viewModel.getVideos()
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}
/*
 NavigationView {
     List(videos, id: \.id) { video in
         NavigationLink(
         destination: VideoDetailView(video: video), label: {
             HStack {
                 Image(video.imageName)
                     .resizable()
                     .scaledToFit()
                     .frame(height: 70)
                     .cornerRadius(4)
                     .padding(.vertical, 4)
                  VStack(alignment: .leading, spacing: 5) {
                     Text(video.title)
                         .fontWeight(.semibold)
                         .lineLimit(2)
                         .minimumScaleFactor(0.5)
                     
                     Text(video.uploadDate)
                         .font(.subheadline)
                         .foregroundColor(.secondary)
                 }
             }
         })
     }
     .navigationTitle("TOP 10")
 }
 */

struct VideosListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView()
    }
}
