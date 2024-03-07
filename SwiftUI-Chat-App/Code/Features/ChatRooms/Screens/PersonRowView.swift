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
            HStack {
                RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                        .frame(width: 60,height: 60)
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
                
                
                VStack(alignment: .leading) {
                    Text(person.getFullName)
                        .modifier(PTSansRegularTextModifier())
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    Text(person.getLastMessage)
                        .modifier(PTSansBoldTextModifier())
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal,15)
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
