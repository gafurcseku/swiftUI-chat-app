//
//  APIClient.swift
//  Qurais
//
//  Created by Md Abdul Gafur on 2/8/23.
//

import Foundation
import Alamofire

public enum ResponseCode:Int {
    case Success = 200
    case Created = 201
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
}


public enum Response<T> {
    case success(T)
    case failure(String,Int)
}

public enum Result<T> {
    case success(T)
    case failure(ErrorResponse)
}

typealias CompletionHandler<T> = (Result<T>) -> ()
typealias CompletionHandlerWithHeaders<T> = (Result<T>, [AnyHashable : Any]?) -> ()

public typealias ErrorResponse = (Int, Data?, Error)

class APIClient {
    
    private static var privateShared : APIClient?
    
    class var shared: APIClient {
        guard let uwShare = privateShared else {
            privateShared = APIClient()
            return privateShared ?? APIClient()
        }
        return uwShare
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    func objectAPICall<T: Decodable>(apiEndPoint: ChatAppEndpoint,modelType:T.Type,content:[String] = ["application/json"],completion: @escaping CompletionHandler<T>) {
        
        AF.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query,encoding: apiEndPoint.encoding,headers: apiEndPoint.headers,requestModifier: apiEndPoint.requestModifier)
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
    
    func fileUpload<T:Decodable>(apiEndPoint: ChatAppEndpoint,modelType: T.Type, content:[String] = ["application/json"],completion: @escaping CompletionHandler<T>) {
        
        AF.upload(multipartFormData: { multipartFormData in
            if let data = apiEndPoint.query["data"] as? Data , let withName = apiEndPoint.query["withName"] as? String, let fileName = apiEndPoint.query["fileName"] as? String, let mimeType = apiEndPoint.query["mimeType"] as? String {
                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mimeType)
            }
        }, to: apiEndPoint.path, method: apiEndPoint.method, headers: apiEndPoint.headers,requestModifier: apiEndPoint.requestModifier)
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
