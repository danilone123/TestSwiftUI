//
//  VideoCellView.swift
//  Test
//
//  Created by danny on 08/09/2023.
//

import SwiftUI

struct VideoCellView: View {
let video: Video
var body: some View {
    HStack {
        AsyncImage(url: URL(string: video.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 100)
                .cornerRadius(16)
        } placeholder: {
            Rectangle()
                .frame(width: 80, height: 100)
                .foregroundColor(.secondary)
                .cornerRadius(16)
        }
        
        VStack(alignment: .leading, spacing: 5) {
            Text(video.userName ?? "")
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
             Text("duration time: \(video.duration) sec")
                .font(.subheadline)
                .foregroundColor(.secondary)
         }
        .padding(.leading)
    }
}
}

struct VideoCellView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCellView(video: Video())
    }
}
