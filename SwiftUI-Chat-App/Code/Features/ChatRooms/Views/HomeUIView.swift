//
//  HomeUIView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 5/3/24.
//

import SwiftUI

struct HomeUIView: View {
    @StateObject private var viewModel = ChatRoomViewModels()
    @State var blockAlert = false
    @State var reportAlert = false
   
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HeaderTitleView(text: "Chats",enableBack: false)
                if(viewModel.chatRoomFail){
                    VStack(alignment: .center,spacing: 10) {
                        Image(systemName: "xmark.icloud.fill")
                            .resizable().frame(width: 50,height: 50)
                        Text("Unable to load Chat Rooms")
                            .modifier(PTSansBoldTextModifier(fontSize: 22))
                        Button(action: { viewModel.getRoomUser() }, label: {
                            Text("Retry")
                                .modifier(PTSansBoldTextModifier(fontSize: 24))
                                .foregroundColor(.black)
                        })
                    }
                    .frame(maxWidth:.infinity,maxHeight:.infinity)
                }
                ScrollView(.vertical,showsIndicators: false) {
                    ForEach(0..<viewModel.users.count, id: \.self){ index in
                        let person = viewModel.users[index]
                        NavigationLink(destination: ChatRoomsDetailsView(person: person)){
                            PersonRowView(person: person) { menuAction in
                                switch menuAction {
                                case .Block:
                                    withAnimation(.easeInOut) {
                                        self.viewModel.person = person
                                        self.blockAlert.toggle()
                                    }
                                case .Report:
                                    withAnimation(.easeInOut) {
                                        self.viewModel.person = person
                                        self.reportAlert.toggle()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .modifier(SurfaceBackGround())
            if(self.blockAlert){
                withAnimation(.easeInOut) {
                    AlertBlockUserView(blockAlert: self.$blockAlert,person: self.viewModel.person)
                }
            }else if(self.reportAlert){
                withAnimation(.easeInOut) {
                    AlertReportUserView(reportAlert: self.$reportAlert,person: self.viewModel.person)
                }
            }
        }.zIndex(2)
            
        .onAppear{
            viewModel.getRoomUser()
        }
    }
}

#Preview {
    HomeUIView()
}
