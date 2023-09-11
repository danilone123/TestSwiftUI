//
//  VideoDetailView.swift
//  Test
//
//  Created by danny on 09/09/2023.
//

import SwiftUI

struct VideoDetailView: View {
    let video: Video
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: video.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
            }
            .frame(width: 320)

            
            VStack {
                Text("Chicken wings")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("You will need more money to buy this dsds ")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                Spacer()
                
                HStack(spacing: 40) {
                    VStack(spacing: 5) {
                        Text("Duration")
                            .bold()
                            .font(.caption)
                        Text("700")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .italic()
                    }
                    
                    VStack(spacing: 5) {
                        Text("Width")
                            .bold()
                            .font(.caption)
                        Text("700")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .italic()
                    }
                    
                    VStack(spacing: 5) {
                        Text("Height")
                            .bold()
                            .font(.caption)
                        Text("700")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .italic()
                    }
                    
                }
                .padding(.bottom, 20)
            }            
        }
        .frame(width: 320, height: 450)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingDetail = false
        } label: {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .opacity(0.6)
                
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
