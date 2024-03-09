//
//  PersonRowView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI

struct PersonRowView: View {
    var person:User
    var completion: (MenuType) -> ()
    var body: some View {
        VStack {
            HStack(spacing:22) {
                RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                        .frame(width: 100,height: 100)
                        .contextMenu {
                            Button {
                                completion(MenuType.Block)
                            } label: {
                                Label("Block", image: "block_icon")
                            }
                            Button {
                                completion(MenuType.Report)
                            } label: {
                                Label("Report", image: "report_icon")
                            }
                        }
                
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                    
                    Text(person.getLastMessage)
                        .modifier(PTSansRegularTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            DividerView()
        }
    }
}

public enum MenuType {
    case Report
    case Block
}


#Preview {
    HomeUIView()
}
