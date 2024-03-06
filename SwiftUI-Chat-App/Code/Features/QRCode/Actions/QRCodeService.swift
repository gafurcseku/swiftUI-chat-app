//
//  QRCodeService.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation

class QRCodeService {
    
    func getQrCode(chatId:String,completion: @escaping ResponseHandler<[Messages]>){
        APIClient.shared.objectAPICall(apiEndPoint: ChatRoomsDetailsAPIEndPoint.getHistory(chatId: chatId), modelType: Historys.self) { result in
            switch result {
            case .success(let historys):
                if historys.getStatus {
                    if let messages = historys.data?.getData {
                        completion(Response.success(messages))
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
