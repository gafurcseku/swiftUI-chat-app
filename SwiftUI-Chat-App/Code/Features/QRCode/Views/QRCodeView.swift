//
//  QRCodeView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("QR Code")
                .modifier(PTSansBoldTextModifier(fontSize: 35))
            Divider()
            
            VStack(alignment: .center){
                Text("Mr Khan")
                    .modifier(PTSansBoldTextModifier())
                Text("Attendance Code")
                    .modifier(PTSansRegularTextModifier(fontSize: 24))
                RemoteImage()
                    .frame(width: 234,height: 234)
                
            }
            .background(Color(ColorSet.colorDDDDDD.rawValue))
            .cornerRadius(6)
            
            Text("This is your private code. Show this to your server so that we can understand you’ve arrived for your date. Thanks.")
                .modifier(PTSansRegularTextModifier(fontSize: 20))
            Spacer()
        }
        
    }
}

#Preview {
    
        QRCodeView()
    
}
