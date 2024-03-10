import SwiftUI

/// View model class for managing the details of a chat room.
class ChatRoomDetailsViewModels: BaseViewModel {
    /// Shared instance of SocketClient for handling socket connections.
    let socketIO = SocketClient.shared
    
    /// Published property holding the array of messages in the chat room.
    @Published var messages: [Messages] = []
    
    /// Published property indicating whether fetching chat history failed.
    @Published var chatHistoryFail: Bool = false
    
    /// Published property indicating the status of the socket connection.
    @Published var isSocketConnected: Bool = false
    
    /// Fetches the chat history for the given chat ID.
    /// - Parameter chatId: The ID of the chat room.
    func getChatHistory(chatId: String) {
        ChatRoomsDetailsService().getHistory(chatId: chatId) { result in
            switch result {
            case .success(let messages):
                // Sorting messages by their IDs before assigning
                self.messages = messages.sorted(by: { message1, message2 in
                    message1.getId < message2.getId
                })
            case .failure(_, _):
                self.chatHistoryFail = true
            }
        }
    }
    
    /// Sets up the socket connection.
    func setSocketConnection(chatRooms: String) {
        socketIO.socketConnection { isSuccess in
            self.isSocketConnected = isSuccess
        }
        socketIO.addEventListeners(chatRoom: chatRooms)
    }
    
    /// Sends a message to the specified chat room.
    /// - Parameters:
    ///   - chatRooms: The name of the chat room.
    ///   - message: The message to be sent.
    func sendMessage(chatRooms: String, message: String) {
        socketIO.sendMessage(chatRoom: chatRooms, message: message)
    }
}

