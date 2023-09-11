//
//  ContentView.swift
//  Test
//
//  Created by danny on 07/09/2023.
//

import SwiftUI

struct VideosListView: View {
    @StateObject var viewModel = VideosViewModel()
    @State private var isShowingDetail = false
    @State private var selectedVideo: Video?
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.pexelVideos ?? []) { video in
                    VideoCellView(video: video)
                        .onTapGesture {
                            isShowingDetail = true
                            selectedVideo = video
                        }
                }
                .navigationTitle("Most Popular Videos ")
                .disabled(isShowingDetail)
            }
            .onAppear {
                Task {
                    await viewModel.getVideos()
                }
            }
            .blur(radius: isShowingDetail ? 20 : 0)
            
            if isShowingDetail, let selectedVideo {
                VideoDetailView(video: selectedVideo, isShowingDetail: $isShowingDetail)
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct VideosListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView()
    }
}
