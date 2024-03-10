import Foundation
import Alamofire

/// Enum defining various API endpoints related to chat room details.
enum ChatRoomsDetailsAPIEndPoint: ChatAppEndpoint {
    
    /// Endpoint for fetching chat history for a specific chat ID.
    case getHistory(chatId: String)
    
    /// HTTP method associated with the endpoint.
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getHistory:
            return .get
        }
    }
    
    /// Path of the endpoint.
    var path: String {
        switch self {
        case .getHistory:
            return baseUrl + "v1/chat/history"
        }
    }
    
    /// Query parameters associated with the endpoint.
    var query: [String: Any] {
        switch self {
        case .getHistory(let chatId):
            return ["chat_id": chatId]
        }
    }
}

