import SwiftUI

/// Represents the view for displaying details of a chat room.
struct ChatRoomsDetailsView: View {
    /// Environment variable to control the presentation mode of the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// State variable for holding the message content.
    @State private var message: String = ""
    
    /// State object for managing the view model of the chat room details.
    @StateObject private var viewModels = ChatRoomDetailsViewModels()
    
    /// The user representing the person in the chat room.
    var person: User
    
    var body: some View {
        VStack {
            // Header section displaying user's profile photo, full name, and navigation link to QR code view
            HStack(spacing: 16) {
                RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Text(person.getFullName)
                    .modifier(PTSansBoldTextModifier(fontSize: 22))
                Spacer()
                NavigationLink(destination: QRCodeView(person: person)) {
                    Image("qr_code_icon")
                }
            }
            Divider()
            
            // Handling case when chat History information fails to load
            if viewModels.chatHistoryFail {
                VStack(alignment: .center, spacing: 10) {
                    Image(systemName: "xmark.icloud.fill")
                        .resizable().frame(width: 50, height: 50)
                    Text("Unable to load Chat Info")
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                    Button(action: { viewModels.getChatHistory(chatId: String(person.getID)) }) {
                        Text("Retry")
                            .modifier(PTSansBoldTextModifier(fontSize: 24))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Displaying chat messages
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { value in
                    VStack(spacing: 25) {
                        ForEach(0..<viewModels.messages.count, id: \.self) { index in
                            let message = viewModels.messages[index]
                            if message.getSender == 462 {
                                HStack {
                                    ReceiverRow(text: message.getBody)
                                    Spacer()
                                }
                            } else {
                                HStack {
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
            
            // Input section for sending messages
            VStack(alignment: .leading) {
                HStack {
                    TextField("Message", text: $message)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.colorDDDDDD)
                        )
                    Button(action: {
                        self.message = ""
                        viewModels.sendMessage(chatRooms: person.getChannelName, message: self.message)
                    }) {
                        Image("send_message_icon")
                    }
                }
                .padding(.top, 15)
                
                // Displaying connection status
                if !viewModels.isSocketConnected {
                    Text("SwiftUI Chat App Connecting ...")
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

// Preview of the ChatRoomsDetailsView for large chat list
#Preview("LargeChatList") {
    NavigationStack {
        ChatRoomsDetailsView(person: .init(id: 94, full_name: "Bessie Knight", profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}

// Preview of the ChatRoomsDetailsView for small chat list
#Preview("SmallChatList") {
    NavigationStack {
        ChatRoomsDetailsView(person: .init(id: 97, full_name: "Bessie Knight", profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}

