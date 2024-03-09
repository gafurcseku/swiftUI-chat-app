//
//  ChatRoomsDetailsView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct ChatRoomsDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var message: String = ""
    @StateObject private var viewModels = ChatRoomDetailsViewModels()
    var person:User
    
    var body: some View {
        VStack{
            HStack(spacing:16){
                RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                    .frame(width: 50,height: 50)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Text(person.getFullName)
                    .modifier(PTSansBoldTextModifier(fontSize: 22))
                Spacer()
                NavigationLink(destination: QRCodeView(person: person)){
                    Image("qr_code_icon")
                }
                
            }
            Divider()
            
            if(viewModels.chatRoomFail){
                VStack(alignment: .center,spacing: 10) {
                    Image(systemName: "xmark.icloud.fill")
                        .resizable().frame(width: 50,height: 50)
                    Text("Unable to load Chat Rooms")
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                    Button(action: {  viewModels.getChatHistory(chatId: String(person.getID)) }, label: {
                        Text("Retry")
                            .modifier(PTSansBoldTextModifier(fontSize: 24))
                            .foregroundColor(.black)
                    })
                }
                .frame(maxWidth:.infinity,maxHeight:.infinity)
            }
            ScrollView(.vertical,showsIndicators: false){
                ScrollViewReader { value in
                VStack(spacing: 25){
                    ForEach(0..<viewModels.messages.count, id: \.self){ index in
                        let message = viewModels.messages[index]
                        if(message.getSender == 462){
                            HStack{
                                ReceiverRow(text: message.getBody)
                                Spacer()
                            }
                        }else{
                            
                            HStack{
                                Spacer()
                                SenderRow(text: message.getBody)
                            }
                        }
                    }
                }
                .onChange(of: viewModels.messages.count) { _ in
                    withAnimation {
                        value.scrollTo(viewModels.messages.count - 1)
                    }
                }
            }
                
            }
            Spacer()
            VStack(alignment: .leading){
                HStack{
                    TextField("Message", text: $message)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(.vertical,5)
                        .padding(.horizontal, 25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.colorDDDDDD)
                                        )
                    Button(action: {
                        self.message = ""
                        viewModels.sendMessage(chatRooms: person.getChannelName, message: self.message)
                    }){
                        Image("send_message_icon")
                    }
                }
                .padding(.top,15)
                if !viewModels.isSocketConnected{
                    Text("Connecting to online ...")
                        .modifier(PTSansRegularTextModifier(fontSize: 8))
                        .padding(.leading, 15)
                }
                
            }
       
        }
        .modifier(SurfaceBackGround())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModels.getChatHistory(chatId: String(person.getID))
            viewModels.setSocketConnection()
        }
    }
}

#Preview("LargeChatList") {
    NavigationStack{
        ChatRoomsDetailsView(person: .init(id: 94,full_name: "Bessie Knight",profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}

#Preview("SmallChatList") {
    NavigationStack{
        ChatRoomsDetailsView(person: .init(id: 97,full_name: "Bessie Knight",profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}
