//
//  ChatRoomsService.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import Foundation

class ChatRoomsService {
    
    private static var privateShared : ChatRoomsService?
    
    class var shared: ChatRoomsService {
        guard let uwShare = privateShared else {
            privateShared = ChatRoomsService()
            return privateShared ?? ChatRoomsService()
        }
        return uwShare
    }
    
    func getRooms(completion: @escaping ResponseHandler<[User]>){
        APIClient.shared.objectAPICall(apiEndPoint: ChatRoomsAPIEndPoint.Chat_Rooms, modelType: Rooms.self) { result in
            switch result {
            case .success(let rooms):
                if rooms.getStatus {
                    if let users = rooms.data?.getData {
                        completion(Response.success(users))
                    }else{
                        completion(Response.failure("Chat Room Empty",201))
                    }
                }
            case .failure(let error):
                completion(Response.failure("Chat Api error -\(error.0)",error.0))
            }
        }
    }
}
