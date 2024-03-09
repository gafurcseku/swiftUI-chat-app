//
//  QRCodeView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct QRCodeView: View {
    @StateObject private var viewModel = QRCodeViewModels()
    var person:User
    var body: some View {
        VStack(alignment: .center){
            HeaderTitleView(text: "QR Code")
            
            VStack{
                VStack(alignment: .center){
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                    Text("Attendance Code")
                        .modifier(PTSansRegularTextModifier(fontSize: 20))
                    if let qrCodeDetails = viewModel.qrCodeDetails{
                        
                        RemoteImage.RectangleImage(url: URL(string: qrCodeDetails.getQRCode))
                            .frame(width: 234,height: 234)
                    }
                }
                .padding(30)
                .modifier(Card())
                .padding(.top, 45)
                Text("This is your private code. Show this to your server so that we can understand you’ve arrived for your date. Thanks.")
                    .modifier(PTSansRegularTextModifier(fontSize: 20,textAlignment: .center))
                    .padding(.top,15)
                    .padding([.leading,.trailing], 25)
                Spacer()
            }
            .modifier(SurfaceBackGround())
           
        }
        .navigationBarBackButtonHidden(true)
        
        .onAppear {
            viewModel.getQrCodeDetails(chatId: String(person.getID))
        }
        
    }
}

#Preview {
    NavigationStack {
        QRCodeView(person: .init(id: 94,full_name: "Susan D. Fairchild",profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}

#Preview("Other", body: {
    NavigationStack {
        QRCodeView(person: .init(id: 94,full_name: "Susan D. Fairchild",profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
})
