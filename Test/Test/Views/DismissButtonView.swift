//
//  DismissButton.swift
//  Test
//
//  Created by danny on 12/09/2023.
//

import SwiftUI

struct DismissButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .opacity(0.2)
            
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
        }   
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
