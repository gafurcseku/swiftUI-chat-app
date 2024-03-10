import Foundation
import Alamofire

// Enum defining HTTP response codes
public enum ResponseCode: Int {
    case Success = 200
    case Created = 201
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
}

// Enum defining the response types for API calls
public enum Response<T> {
    case success(T)
    case failure(String, Int)
}

// Enum defining the result types for API calls
public enum Result<T> {
    case success(T)
    case failure(ErrorResponse)
}

// Type alias for completion handler without headers
typealias CompletionHandler<T> = (Result<T>) -> ()

// Type alias for response handler without headers
typealias ResponseHandler<T> = (Response<T>) -> ()

// Type alias for completion handler with headers
typealias CompletionHandlerWithHeaders<T> = (Result<T>, [AnyHashable: Any]?) -> ()

// Type alias for error response tuple
public typealias ErrorResponse = (Int, Data?, Error)

// Class responsible for handling API requests
class APIClient {
    
    // Singleton instance
    private static var privateShared: APIClient?
    
    // Shared instance of APIClient
    class var shared: APIClient {
        guard let uwShare = privateShared else {
            privateShared = APIClient()
            return privateShared ?? APIClient()
        }
        return uwShare
    }
    
    // Destroy the singleton instance
    class func destroy() {
        privateShared = nil
    }
    
    /**
     Method for making API calls returning Decodable objects.
     - Parameters:
        - apiEndPoint: The endpoint configuration defining the details of the API endpoint.
        - modelType: The type of object to be decoded from the API response.
        - content: An array of strings specifying the expected content types in the response. Defaults to ["application/json"].
        - completion: A closure to be executed when the API call completes, returning a Result enum encapsulating either the decoded object on success or an error response on failure.
     */
    func objectAPICall<T: Decodable>(apiEndPoint: ChatAppEndpoint, modelType: T.Type, content: [String] = ["application/json"], completion: @escaping CompletionHandler<T>) {
        
        AF.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding, headers: apiEndPoint.headers, requestModifier: apiEndPoint.requestModifier)
            .validate(statusCode: 200..<300)
            .validate(contentType: content)
            .responseDecodable(of: modelType.self) { response in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    completion(Result.failure(mError))
                }
            }
    }
}

