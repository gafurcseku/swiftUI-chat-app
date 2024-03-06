//
//  ChatRoomDetailsViewModels.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation

class ChatRoomDetailsViewModels : BaseViewModel {
    
    @Published var messages:[Messages] = []
    
    func getChatHistory(chatId:String) {
        ChatRoomsDetailsService().getHistory(chatId: chatId) { result in
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let errorMessage, let errorCode):
                break
            }
        }
    }
}
