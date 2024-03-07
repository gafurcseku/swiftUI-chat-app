//
//  QRCodeViewModels.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation

class QRCodeViewModels : BaseViewModel {
    
    @Published var qrCodeDetails:QRCodeDetails? = nil
    
    func getQrCodeDetails(chatId:String){
        QRCodeService().getQrCode(chatId: chatId) { result in
            switch result {
            case .success(let qr):
                self.qrCodeDetails = qr
            case .failure(let errorMessage, let errorCode):
                break
            }
        }
    }
}
