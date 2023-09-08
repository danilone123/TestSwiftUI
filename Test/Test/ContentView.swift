//
//  ContentView.swift
//  Test
//
//  Created by danny on 07/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = VideosViewModel()
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: pexelVideos?.videos?.first?.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                     .foregroundColor(.secondary)
                     
            }.frame(width: 120, height: 120)

            
            Text("no name")
                .bold()
                .font(.title3)
            Text("This is a test")
                .padding()
            Spacer()
            
            List {
                ForEach(viewModel.pexelVideos ?? []) { video in
                    Text(video.userName ?? "NO name")
                }
            }
            
        }
        .padding()
        .task {
          await viewModel.getVideos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
