import Foundation

/// Service class responsible for fetching chat room data from the API.
class ChatRoomsService {
        
    /// Function to retrieve the list of users in the chat rooms.
    /// - Parameter completion: Closure to handle the response containing either the list of users or an error.
    func getRooms(completion: @escaping ResponseHandler<[User]>) {
        // Call the object API endpoint for fetching chat rooms data
        APIClient.shared.objectAPICall(apiEndPoint: ChatRoomsAPIEndPoint.Chat_Rooms, modelType: Rooms.self) { result in
            switch result {
            case .success(let rooms):
                // Check if the API call was successful
                if rooms.getStatus {
                    // If data is available, pass it to the completion handler
                    if let users = rooms.data?.getData {
                        completion(Response.success(users))
                    } else {
                        // If the chat room is empty, return failure with a custom message and status code 201
                        completion(Response.failure("Chat Room Empty", 201))
                    }
                }
            case .failure(let error):
                // If there's a failure, pass the error details to the completion handler
                completion(Response.failure("Chat Api error -\(error.0)", error.0))
            }
        }
    }
}

