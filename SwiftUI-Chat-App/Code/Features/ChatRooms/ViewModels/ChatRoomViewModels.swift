//
//  ChatRoomViewModels.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import Foundation

class ChatRoomViewModels : BaseViewModel {
    
    @Published var users:[User] = []
    
    func getRoomUser() {
        ChatRoomsService().getRooms { result in
            switch result {
            case .success(let users):
                print(users)
                self.users = users
            case .failure(let errorMessage, let errorCode):
                break
            }
        }
    }
}
