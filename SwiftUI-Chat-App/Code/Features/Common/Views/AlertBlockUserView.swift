//
//  AlertBlockUserView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct AlertBlockUserView: View {
    @Binding var blockAlert: Bool
    var person:User = .init()
    var body: some View {
        CustomAlert(showAlert:self.$blockAlert,positiveText: "BLOCK"){
            VStack(alignment: .leading,spacing: 15){
                HStack(spacing:10){
                    Image("block_user_icon")
                    Text("Block User")
                        .modifier(PTSansBoldTextModifier(fontSize: 30))
                        .foregroundColor(.black)
                }
                HStack(spacing:15){
                    RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                        .frame(width: 50,height: 50)
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                }
                
                Text("Are you sure you want to block this user? Once blocked they won’t be able to send you messages and won’t be able to match in future.")
                    .modifier(PTSansRegularTextModifier(fontSize: 16))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    AlertBlockUserView(blockAlert: .constant(false))
}
