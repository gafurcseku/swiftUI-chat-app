//
//  SurfaceViewModifier.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import SwiftUI

struct SurfaceBackGround : ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .padding()
    }
}


struct Card : ViewModifier {
    var padding:CGFloat = 25
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(Color(ColorSet.colorDDDDDD.rawValue).opacity(0.5))
            .cornerRadius(20)
    }
}

#Preview {
    VStack{
       Text("Hi Jenny, Glad we matched. Your profile looks amazing! Looking forward to our date at NORTH END coffee roasters Banani - Borak Mehnur")
            .frame(width: 300, height: 300)
    }
    .modifier(Card())
}
