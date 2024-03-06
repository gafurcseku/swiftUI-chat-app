import Foundation
import Alamofire

 let baseUrl = "https://backend.ohodating.com/api/"

protocol ChatAppEndpoint {
    var method:HTTPMethod { get }
    var path:String { get }
    var query:[String:Any] { get }
    var encoding: ParameterEncoding {get set}
    var headers: HTTPHeaders {get set}
    var requestModifier: (inout URLRequest) throws -> Void {get set}
}

extension ChatAppEndpoint {
    var encoding:ParameterEncoding {get {
        if(method.rawValue == "GET"){
            return URLEncoding(boolEncoding: .literal)
        }else {
            return JSONEncoding.default
        }
    } set{}}
    
    var headers: HTTPHeaders {
        get {
            let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTAzMTM2MjksImlhdCI6MTcwOTQ0OTYyOSwic3ViIjo0NjIsInVzZXJfdHlwZSI6Im9obyJ9.-1_K9LobxzyUkc9qgxmaBommiOzTr7ewKUyZ15er79g"
            return ["Authorization" :  token]
        }
        set{}
    }
    
    var requestModifier : (inout URLRequest) throws -> Void {
        get {
            return { urlRequest in
                urlRequest.timeoutInterval = 60
            }
        } set{}
    }
}
