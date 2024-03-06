//
//  DashBoardUIView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 6/3/24.
//

import SwiftUI

struct DashBoardUIView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeUIView()
                    .tabItem {
                        Label("Home", image: "home_bottom")
                    }
                
                Text("Home")
                    .tabItem {
                        Label("", image: "favorite_bottom_icon")
                    }
                
                Text("Home")
                    .tabItem {
                        Label("", image: "person_bottom_icon")
                    }
                Text("Home")
                    .tabItem {
                        Label("", image: "message_bottom_icon")
                    }
                Text("Home")
                    .tabItem {
                        Label("", image: "more_bottom_icon")
                    }
            }
            .accentColor(Color(ColorSet.colorB42254.rawValue))
        }
    }
}

#Preview {
    DashBoardUIView()
}
