/// Service class responsible for fetching chat room history data from the API.
class ChatRoomsDetailsService {
    
    /// Fetches chat room history for the specified chat ID.
    /// - Parameters:
    ///   - chatId: The ID of the chat room.
    ///   - completion: A closure to be executed when the history retrieval is completed. It takes a result of type `ResponseHandler<[Messages]>`, indicating success or failure.
    func getHistory(chatId: String, completion: @escaping ResponseHandler<[Messages]>) {
        // Make an API call to fetch chat history data
        APIClient.shared.objectAPICall(apiEndPoint: ChatRoomsDetailsAPIEndPoint.getHistory(chatId: chatId), modelType: Historys.self) { result in
            switch result {
            case .success(let historys):
                // Check if the API call was successful and history data is available
                if historys.getStatus {
                    if let messages = historys.data?.getData {
                        // If messages are available, pass them to the completion handler as a success response
                        completion(Response.success(messages))
                    } else {
                        // If chat room is empty, pass failure response with appropriate message and code
                        completion(Response.failure("Chat Room Empty", 201))
                    }
                }
            case .failure(let error):
                // If API call fails, pass failure response with error details
                completion(Response.failure("Chat Api error -\(error.0)", error.0))
            }
        }
    }
}

