//
//  QRCodeAPIEndPoint.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation
import Alamofire

enum QRCodeAPIEndPoint : ChatAppEndpoint {
    
    case getQRCode(chatId:String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getQRCode:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getQRCode:
            return baseUrl + "v1/match/get_qr_code"
        }
    }
    
    var query: [String : Any] {
        switch self {
        case .getQRCode(let chatId):
            return ["chat_id":chatId]
        }
    }
    
    
}
