//
//  ChatRoomsAPIEndPoint.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import Foundation
import Alamofire

enum ChatRoomsAPIEndPoint : ChatAppEndpoint {
    
    case Chat_Rooms
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Chat_Rooms:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Chat_Rooms:
            return baseUrl + "v1/chat/rooms"
        }
    }
    
    var query: [String : Any] {
        switch self {
        case .Chat_Rooms:
            return [String:Any]()
        }
    }
    
    
}
