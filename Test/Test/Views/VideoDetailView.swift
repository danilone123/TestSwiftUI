//
//  VideoDetailView.swift
//  Test
//
//  Created by danny on 09/09/2023.
//

import SwiftUI
import AVKit
import CoreData

struct VideoDetailView: View {
    let video: Video
    @Binding var isShowingDetail: Bool
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack {
            //if the video is not available show an image
            if let urlText = video.link, let url = URL(string: urlText) {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 380)
            } else {
                AsyncImage(url: URL(string: video.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 380)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(height: 380)
                }
            }
            
            VStack {
                Text(networkMonitor.isConnected ?  "by \(video.userName ?? "")" : "NOT CONNECTED")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(networkMonitor.isConnected ? .white : .red)

                Spacer()

                HStack(spacing: 40) {
                    InfoView(title: "Duration", value: "\(video.duration) sec")
                    InfoView(title: "Quality", value: video.quality ?? "")
                }
                .padding(.bottom, 20)
            }
        }
        .frame(width: 320, height: 500)
        .background(Color(.black))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingDetail = false
        } label: {
            DismissButtonView()
        }, alignment: .topTrailing)
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewVideo = PreviewVideo()
        VideoDetailView(video: previewVideo.video, isShowingDetail: .constant(true)).environmentObject(NetworkMonitor())
    }
}

struct InfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            Text(String(value))
                .fontWeight(.semibold)
                .italic()
        }.foregroundColor(.white)
    }
}
