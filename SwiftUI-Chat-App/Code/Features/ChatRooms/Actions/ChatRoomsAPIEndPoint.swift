import Foundation
import Alamofire

/// Enum defining endpoints related to chat rooms for the ChatApp API.
enum ChatRoomsAPIEndPoint: ChatAppEndpoint {
    
    /// Endpoint for fetching chat rooms.
    case Chat_Rooms
    
    /// HTTP method associated with each endpoint.
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Chat_Rooms:
            return .get
        }
    }
    
    /// Path of the API endpoint.
    var path: String {
        switch self {
        case .Chat_Rooms:
            return baseUrl + "v1/chat/rooms"
        }
    }
    
    /// Query parameters for the API endpoint.
    var query: [String: Any] {
        switch self {
        case .Chat_Rooms:
            return [:] // No query parameters for this endpoint
        }
    }
}

