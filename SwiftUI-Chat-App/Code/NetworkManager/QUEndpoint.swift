import Foundation
import Alamofire

 let baseUrl = Bundle.main.infoDictionary?["BaseUrl"] as? String  ?? ""

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
            return ["Authorization" :  Bundle.main.infoDictionary?["aServiceToken"] as? String  ?? ""]
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
