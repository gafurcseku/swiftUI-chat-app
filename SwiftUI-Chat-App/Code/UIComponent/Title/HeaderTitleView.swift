//
//  HeaderTitleView.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 8/3/24.
//

import SwiftUI

struct HeaderTitleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var text:String = "Title"
    var enableBack:Bool = true
    var body: some View {
        VStack(alignment: .leading){
            Text(text)
                .modifier(PTSansBoldTextModifier(fontSize: 35))
                .foregroundColor(.black)
                .padding()
                .onTapGesture {
                    if enableBack {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            DividerView()
        }
    }
}

#Preview {
    HeaderTitleView()
}
