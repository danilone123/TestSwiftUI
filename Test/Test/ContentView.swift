//
//  ContentView.swift
//  Test
//
//  Created by danny on 07/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var pexelVideos: PexelVideos?
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

            
            Text(pexelVideos?.videos?.first?.user?.name ?? "no name")
                .bold()
                .font(.title3)
            Text("This is a test")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            let test = APIManager()
            pexelVideos = try? await test.doRequest(endPoint: "https://api.pexels.com/videos/popular?per_page=3")
            
        }
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
