//
//  GLRemoteImage.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

struct RemoteImage: View {
    var url = URL(string: "https://picsum.photos/200")
    var body: some View {
        AsyncImage(url: url,content: view)
            .clipShape(Circle())
    }
    
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
           switch phase {
           case .empty:
               ProgressView()
           case .success(let image):
               image
                   .resizable()
                   .aspectRatio(contentMode: .fit)
           case .failure(let error):
               VStack(spacing: 16) {
                   Image(systemName: "xmark.octagon.fill")
                       .foregroundColor(.red)
               }
           @unknown default:
               Text("Unknown")
                   .foregroundColor(.gray)
           }
       }
}

#Preview {
    RemoteImage()
}
