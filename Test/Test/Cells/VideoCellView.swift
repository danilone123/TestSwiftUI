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
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
        } placeholder: {
            Rectangle()
                .foregroundColor(.secondary)
        }.frame(width: 90, height: 70)
         VStack(alignment: .leading, spacing: 5) {
            Text(video.userName ?? "")
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
             Text("duration time: \(video.duration) sec")
                .font(.subheadline)
                .foregroundColor(.secondary)
         }.padding(.leading)
    }
}
}

struct VideoCellView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCellView(video: Video())
    }
}
