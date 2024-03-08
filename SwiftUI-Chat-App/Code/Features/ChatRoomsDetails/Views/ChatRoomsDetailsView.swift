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
    var person:User = .init(id: 94,profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d")
    
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
            HStack{
                TextField("Course type", text: $message)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black)
                                    )
                Button(action: {}){
                    Image("send_message_icon")
                }
            }
            .padding(.top,15)
        }
        .modifier(SurfaceBackGround())
        .navigationBarBackButtonHidden(true)
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
