//
//  AlertReportUserView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct AlertReportUserView: View {
    @Binding var reportAlert: Bool
    var person:User = .init()
    var body: some View {
        CustomAlert(showAlert:self.$reportAlert,positiveText: "REPORT"){
            VStack(alignment: .leading,spacing: 15){
                HStack(spacing:10){
                    Image("block_user_icon")
                    Text("Report User")
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
                
                Text("Please select your reasons for reporting this user. Once someone’s profile is reported we verify and take necessary measures against them.")
                    .modifier(PTSansRegularTextModifier(fontSize: 16))
                    .foregroundColor(.black)
                VStack(alignment: .leading){
                    CheckBoxView(checked: .constant(false)){
                        Text("Impersonation")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    CheckBoxView(checked: .constant(false)){
                        Text("Inappropriate Behavior")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    CheckBoxView(checked: .constant(false)){
                        Text("Threats or Violence")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .modifier(Card(padding: 10))
            }
            .padding(.bottom,25)
        }
    }
}

#Preview {
    AlertReportUserView(reportAlert: .constant(false))
}
