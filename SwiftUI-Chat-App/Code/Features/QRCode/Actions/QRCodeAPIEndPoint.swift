import Foundation
import Alamofire

/// Enum defining various API endpoints related to QR code operations.
enum QRCodeAPIEndPoint: ChatAppEndpoint {
    
    /// Endpoint for fetching QR code for a specific chat ID.
    case getQRCode(chatId: String)
    
    /// HTTP method associated with the endpoint.
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getQRCode:
            return .get
        }
    }
    
    /// Path of the endpoint.
    var path: String {
        switch self {
        case .getQRCode:
            return baseUrl + "v1/match/get_qr_code"
        }
    }
    
    /// Query parameters associated with the endpoint.
    var query: [String: Any] {
        switch self {
        case .getQRCode(let chatId):
            return ["chat_id": chatId]
        }
    }
}

