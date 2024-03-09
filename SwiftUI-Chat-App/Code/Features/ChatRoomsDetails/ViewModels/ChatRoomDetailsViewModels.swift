//
//  ChatRoomDetailsViewModels.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

class ChatRoomDetailsViewModels : BaseViewModel {
    let socketIO = SocketClient.shared
    @Published var messages:[Messages] = []
    @Published var chatRoomFail:Bool = false
    @Published var isSocketConnected:Bool = false
    
    func getChatHistory(chatId:String) {
        ChatRoomsDetailsService().getHistory(chatId: chatId) { result in
            switch result {
            case .success(let messages):
                self.messages = messages.sorted(by: { message1, message2 in
                    message1.getId < message2.getId
                })
            case .failure( _, _):
                self.chatRoomFail = true
            }
        }
    }
    
    func setSocketConnection(){
        socketIO.socketConnection { isSuccess in
            self.isSocketConnected = isSuccess
        }
    }
    
    func sendMessage(chatRooms:String,message:String){
        socketIO.sendMessage(chatRoom: chatRooms, message: message)
    }
}
