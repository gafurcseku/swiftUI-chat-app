//
//  PersonRowView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI

struct PersonRowView: View {
    var body: some View {
        HStack {
                   Image("person.image")
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: 50, height: 50)
                       .clipShape(Circle())
                       .padding()

                   VStack(alignment: .leading) {
                       Text("person.name")
                           .font(.custom("PTSans-Regular", size: 16))
                           .foregroundColor(.black)
                           .padding(.bottom, 5)

                       Text("person.lastMessage")
                           .font(.custom("PTSans-Regular", size: 16)) 
                           .foregroundColor(.gray)
                   }

                   Spacer()
               }
               .padding(.vertical, 8)
    }
}

#Preview {
    PersonRowView()
}
