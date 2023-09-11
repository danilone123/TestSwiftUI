//
//  VideoDetailView.swift
//  Test
//
//  Created by danny on 09/09/2023.
//

import SwiftUI
import AVKit

struct VideoDetailView: View {
    let video: Video
    @Binding var isShowingDetail: Bool
    
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
                Text("by \(video.userName ?? "")")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 40) {
                    VStack(spacing: 5) {
                        Text("Duration")
                            .bold()
                            .font(.caption)
                        Text(String("\(video.duration) sec"))
                            .fontWeight(.semibold)
                            .italic()
                    }.foregroundColor(.white)
                    
                    VStack(spacing: 5) {
                        Text("Quality")
                            .bold()
                            .font(.caption)
                        Text(video.quality ?? "")
                            .fontWeight(.semibold)
                            .italic()
                    }.foregroundColor(.white)
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
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(0.2)
                
                Image(systemName: "xmark")
                    .imageScale(.medium)
                    .frame(width: 44, height: 44)
            }
        }, alignment: .topTrailing)
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(video: Video(), isShowingDetail: .constant(true))
    }
}
