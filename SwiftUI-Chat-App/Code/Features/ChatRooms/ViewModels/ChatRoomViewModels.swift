//
//  ChatRoomViewModels.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI


class ChatRoomViewModels : BaseViewModel {
    
    @Published var users:[User] = []
    @Published var chatRoomFail:Bool = false
    var person:User = .init()
    
    func getRoomUser() {
        ChatRoomsService().getRooms { result in
            switch result {
            case .success(let users):
                withAnimation {
                    self.users = users
                }
            case .failure(_, _):
                self.chatRoomFail = true
            }
        }
    }
}
