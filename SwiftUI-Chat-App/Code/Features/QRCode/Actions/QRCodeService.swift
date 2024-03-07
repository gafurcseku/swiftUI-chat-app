//
//  QRCodeService.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation

class QRCodeService {
    
    func getQrCode(chatId:String,completion: @escaping ResponseHandler<QRCodeDetails>){
        APIClient.shared.objectAPICall(apiEndPoint: QRCodeAPIEndPoint.getQRCode(chatId: chatId), modelType: QRCode.self) { result in
            switch result {
            case .success(let qrCode):
                if qrCode.getStatus {
                    if let qrDetails = qrCode.data {
                        completion(Response.success(qrDetails))
                    }else{
                        completion(Response.failure("No Data",201))
                    }
                }
            case .failure(let error):
                completion(Response.failure("Chat Api error -\(error.0)",error.0))
            }
        }
    }
}
