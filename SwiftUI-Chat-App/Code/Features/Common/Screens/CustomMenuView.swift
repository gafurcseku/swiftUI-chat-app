//
//  CustomMenuView.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 7/3/24.
//

import SwiftUI

struct CustomMenu<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(width: 234)
        .background(
            Color(UIColor.systemBackground)
                .opacity(0.8)
                .blur(radius: 50)
        )
        .cornerRadius(14)
    }
}

struct CustomMenuButtonStyle: ButtonStyle {
    let symbol: String
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: symbol)
            Spacer()
            configuration.label
        }
        .padding(.horizontal, 16)
        .foregroundColor(color)
        .background(configuration.isPressed ? Color(UIColor.secondarySystemBackground) : Color.clear)
        .frame(height: 44)
    }
}

