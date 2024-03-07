//
//  PersonRowView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI

struct PersonRowView: View {
    var person:User
    var body: some View {
        HStack {
            
                RemoteImage(url: URL(string: person.getProfilePhoto))
                    .frame(width: 100,height: 100)
                    .contextMenu {
                        Button {
                            
                        } label: {
                            Label("Share Post", systemImage: "flame.fill")
                        }
                    }
            
            
            VStack(alignment: .leading) {
                Text(person.getFullName)
                    .modifier(PTSansRegularTextModifier())
                    .padding(.bottom, 5)
                
                Text(person.getLastMessage)
                    .modifier(PTSansBoldTextModifier())
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    HomeUIView()
}
