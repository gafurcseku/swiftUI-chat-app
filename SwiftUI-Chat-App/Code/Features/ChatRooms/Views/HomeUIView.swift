//
//  HomeUIView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 5/3/24.
//

import SwiftUI

struct HomeUIView: View {
    @StateObject private var viewModel = ChatRoomViewModels()
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false) {
                ForEach(0..<viewModel.users.count, id: \.self){ index in
                    let person = viewModel.users[index]
                    NavigationLink(destination: ChatRoomsDetailsView(person: person)){
                        PersonRowView(person: person)
                    }
                }
            }
        }
        .onAppear{
            viewModel.getRoomUser()
        }
    }
}

#Preview {
    HomeUIView()
}
