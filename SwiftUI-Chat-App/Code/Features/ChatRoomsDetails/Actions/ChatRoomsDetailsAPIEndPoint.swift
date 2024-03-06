//
//  ChatRoomsDetailsAPIEndPoint.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation
import Alamofire

enum ChatRoomsDetailsAPIEndPoint : ChatAppEndpoint {
    
    case getHistory(chatId:String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getHistory:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHistory:
            return baseUrl + "v1/chat/history"
        }
    }
    
    var query: [String : Any] {
        switch self {
        case .getHistory(let chatId):
            return ["chat_id":chatId]
        }
    }
    
    
}
