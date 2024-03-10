import Foundation
import Alamofire

 let baseUrl = Bundle.main.infoDictionary?["BaseUrl"] as? String  ?? ""

/**
 Protocol defining the structure for endpoints used in the ChatApp API.
 
 Implementations of this protocol provide details for making API requests, including HTTP method, path, query parameters, encoding, headers, and request modifiers.
 */
protocol ChatAppEndpoint {
    // HTTP method for the endpoint
    var method: HTTPMethod { get }
    
    // Path for the endpoint
    var path: String { get }
    
    // Query parameters for the endpoint
    var query: [String: Any] { get }
    
    // Parameter encoding method for the request
    var encoding: ParameterEncoding { get set }
    
    // HTTP headers for the request
    var headers: HTTPHeaders { get set }
    
    // Request modifier closure to customize the request before it is sent
    var requestModifier: (inout URLRequest) throws -> Void { get set }
}

/**
 Extension providing default implementations for properties of the ChatAppEndpoint protocol.
 
 This extension defines default values for the `encoding`, `headers`, and `requestModifier` properties, making it easier to conform to the protocol. It sets URL encoding for GET requests and JSON encoding for other requests by default. It also provides a default authorization header using the service token from the main bundle's info dictionary. Additionally, it sets a default request timeout interval of 60 seconds.
 */
extension ChatAppEndpoint {
    // Default implementation for encoding property
    var encoding: ParameterEncoding {
        get {
            if method.rawValue == "GET" {
                return URLEncoding(boolEncoding: .literal)
            } else {
                return JSONEncoding.default
            }
        }
        set {}
    }
    
    // Default implementation for headers property
    var headers: HTTPHeaders {
        get {
            return ["Authorization": Bundle.main.infoDictionary?["ServiceToken"] as? String ?? ""]
        }
        set {}
    }
    
    // Default implementation for requestModifier property
    var requestModifier: (inout URLRequest) throws -> Void {
        get {
            return { urlRequest in
                urlRequest.timeoutInterval = 60
            }
        }
        set {}
    }
}
