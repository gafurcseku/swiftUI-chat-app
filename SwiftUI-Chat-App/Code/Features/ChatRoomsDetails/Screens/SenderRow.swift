//
//  SenderRow.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct SenderRow: View {
    var text:String
    var body: some View {
        Text(text)
            .modifier(PTSansRegularTextModifier(fontSize: 18))
            .foregroundColor(.white)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.colorB42254, .colorFF6FA0]), startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(30)
            .padding(.leading, 80)
    }
}

#Preview {
    SenderRow(text: "Excited for our date tomorrow :D")
}
