import SwiftUI

/// ViewModel class responsible for managing data related to a chat room in an application.
class ChatRoomViewModels: BaseViewModel {
    
    /// Published property to hold the list of users in the chat room.
    @Published var users: [User] = []
    
    /// Published property indicating whether there was a failure while fetching chat room data.
    @Published var chatRoomFail: Bool = false
    
    /// Property representing a single user.
    var person: User = .init()
    
    /// Function to fetch users belonging to the chat room.
    func getRoomUser() {
        ChatRoomsService().getRooms { result in
            switch result {
            case .success(let users):
                // Update users with animation
                withAnimation {
                    self.users = users
                }
            case .failure(_, _):
                // Set chatRoomFail flag to true in case of failure
                self.chatRoomFail = true
            }
        }
    }
}

