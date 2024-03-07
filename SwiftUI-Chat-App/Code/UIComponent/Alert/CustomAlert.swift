//
//  CustomAlert.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct CustomAlert: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Text("alertType.title()")
                Text("alertType.message()")
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                HStack(spacing: 0) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("alertType.leftActionText")
                    }
                    Divider().frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Text("alertType.rightActionText")
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                .padding([.horizontal, .bottom], 0)
            }
            .background(Color.white)
        }
        .zIndex(2)
    }
}


#Preview {
    CustomAlert()
}
