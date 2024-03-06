//
//  Font+Extensions.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

public extension Font {
    enum CustomFont:String {
        case PTSansRegular = "PTSans-Regular"
        case PTSansBold = "PTSans-Bold"
    }
    
    static func PTSansRegular(ofSize size: CGFloat) -> Font {
        .custom(CustomFont.PTSansRegular.rawValue, size: size)
    }
    
    static func PTSansBold(ofSize size: CGFloat) -> Font {
        .custom(CustomFont.PTSansBold.rawValue, size: size)
    }
}
