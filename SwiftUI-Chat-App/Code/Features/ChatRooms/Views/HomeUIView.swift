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
        VStack(alignment: .leading){
            Text("Chats")
                .modifier(PTSansBoldTextModifier(fontSize: 35))
                .foregroundColor(.black)
                .padding()
            DividerView()
            
            ScrollView(.vertical,showsIndicators: false) {
                ForEach(0..<viewModel.users.count, id: \.self){ index in
                    let person = viewModel.users[index]
                    NavigationLink(destination: ChatRoomsDetailsView(person: person)){
                        PersonRowView(person: person) { menuAction in
                            switch menuAction {
                            case .Block:
                                withAnimation {
                                    self.viewModel.person = person
                                    self.blockAlert.toggle()
                                }
                            case .Report:
                                withAnimation {
                                    self.viewModel.person = person
                                    self.reportAlert.toggle()
                                }
                            }
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: self.$blockAlert, content: {
            AlertBlockUserView(blockAlert: self.$blockAlert,person: self.viewModel.person)
        })
        .fullScreenCover(isPresented: self.$reportAlert, content: {
            AlertReportUserView(reportAlert: self.$reportAlert,person: self.viewModel.person)
        })
        .onAppear{
            viewModel.getRoomUser()
        }
    }
}

#Preview {
    HomeUIView()
}
