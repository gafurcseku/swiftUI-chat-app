//
//  Text+ViewModifier.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI

struct PTSansRegularTextModifier : ViewModifier {
    var fontSize:CGFloat = 16.0
    var textAlignment:TextAlignment = .leading
    func body(content: Content) -> some View {
        content
            .font(.PTSansRegular(ofSize: fontSize))
            .multilineTextAlignment(textAlignment)
    }
}


struct PTSansBoldTextModifier : ViewModifier {
    var fontSize:CGFloat = 22.0
    func body(content: Content) -> some View {
        content
            .font(.PTSansBold(ofSize: fontSize))
    }
}
