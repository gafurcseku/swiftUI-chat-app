//
//  CustomAlert.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct CustomAlert<Content> : View where Content : View {
    @Binding var showAlert: Bool
    var negativeText:String = "CANCEL"
    var positiveText:String = "OK"
    
    @ViewBuilder let content: Content
    var negativeButtonAction: (() -> ())?
    var positiveButtonAction: (() -> ())?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.showAlert.toggle()
                }
            VStack(spacing: 0) {
                content
                HStack(spacing: 21) {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.showAlert.toggle()
                        }
                        negativeButtonAction?()
                    }){
                        Text(negativeText)
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.showAlert.toggle()
                        }
                        positiveButtonAction?()
                    }){
                        Text(positiveText)
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.red)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                
            }
            .padding([.leading, .trailing], Padding.p25.rawValue)
            .padding(.top,Padding.p50.rawValue)
            .padding(.bottom,Padding.p25.rawValue)
            .background(Color.white)
            .padding([.leading,.trailing],25)
            
        }
        .zIndex(2)
    }
}


#Preview {
    CustomAlert(showAlert:.constant(false),positiveText: "BLOCK"){
        VStack(alignment: .leading,spacing: 15){
            HStack(spacing:10){
                Image("block_user_icon")
                Text("Block User")
                    .modifier(PTSansBoldTextModifier(fontSize: 30))
                    .foregroundColor(.black)
            }
            HStack(spacing:15){
                RemoteImage.CircleImage()
                    .frame(width: 50,height: 50)
                Text("Susan D. Fairchild")
                    .modifier(PTSansBoldTextModifier(fontSize: 22))
                    .foregroundColor(.black)
            }
            
            Text("Are you sure you want to block this user? Once blocked they won’t be able to send you messages and won’t be able to match in future.")
                .modifier(PTSansRegularTextModifier(fontSize: 16))
                .foregroundColor(.black)
        }
    }
}
