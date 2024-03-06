//
//  Font+Extensions.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

public extension Font {
    enum CustomFont:String {
        case same = "value"
    }
    
    static func nameSemibold(ofSize size: CGFloat) -> Font {
        .custom(CustomFont.same.rawValue, size: size)
    }
}
