//
//  ChatRoomsDetailsView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct ChatRoomsDetailsView: View {
    @StateObject private var viewModels = ChatRoomDetailsViewModels()
    var person:User = .init(id: 94,profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d")
    
    var body: some View {
        VStack{
            HStack(spacing:16){
                RemoteImage(url: URL(string: person.getProfilePhoto))
                    .frame(width: 50,height: 50)
                Text(person.getFullName)
                    .modifier(PTSansBoldTextModifier(fontSize: 22))
                Spacer()
                NavigationLink(destination: QRCodeView(person: person)){
                    Image("qr_code_icon")
                }
                
            }
            Divider()
            Spacer()
        }
        .modifier(SurfaceBackGround())
        .onAppear {
            viewModels.getChatHistory(chatId: String(person.getID))
        }
    }
}

#Preview {
    NavigationStack{
        ChatRoomsDetailsView()
    }
}
