//
//  QUEndpoint.swift
//  Qurais
//
//  Created by Md Abdul Gafur on 2/8/23.
//

import Foundation
import Alamofire

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
            let accesToken:String = ApplicationUserDefault.getString(key: USER_TOKEN)
            if accesToken.isEmpty { return HTTPHeaders.default } else {
                let token = "Bearer " + accesToken
                return ["Authorization" :  token]
                
//                return ["Authorization" :  token, "deviceType":"iOS","deviceId":"Helper.deviceID" , "appVersion": "Helper.appVersion","deviceName":"Helper.getDeviceName","Content-type": "multipart/form-data", "Content-Disposition" : "form-data"]
            }
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
