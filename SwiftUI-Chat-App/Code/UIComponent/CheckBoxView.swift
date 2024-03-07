//
//  CheckBoxView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct CheckBoxView<Content> : View where Content : View {
    @Binding var checked: Bool
    @ViewBuilder let content: Content
    var body: some View {
        HStack(spacing:21){
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .renderingMode(.template)
                .frame(width: 18,height: 18)
                .foregroundColor(checked ? Color.red : Color.black)
                .onTapGesture {
                    self.checked.toggle()
                }
            content
            Spacer()
        }
        
    }
}

#Preview {
    CheckBoxView(checked: .constant(true)){
        Text("aaaa")
    }
}
