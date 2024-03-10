import SwiftUI

/// Represents the main dashboard view of the application.
struct DashBoardUIView: View {
    var body: some View {
        NavigationStack {
            // TabView containing different sections of the dashboard
            TabView {
                // HomeUIView for displaying home content
                HomeUIView()
                    .tabItem {
                        Label("Home", image: "home_bottom")
                    }
                
                // Placeholder for favorite section
                Text("Favorite")
                    .tabItem {
                        Label("", image: "favorite_bottom_icon")
                    }
                
                // Placeholder for person section
                Text("Person")
                    .tabItem {
                        Label("", image: "person_bottom_icon")
                    }
                
                // Placeholder for message section
                Text("Message")
                    .tabItem {
                        Label("", image: "message_bottom_icon")
                    }
                
                // Placeholder for more section
                Text("More")
                    .tabItem {
                        Label("", image: "more_bottom_icon")
                    }
            }
            // Set the accent color for the TabView
            .accentColor(Color.colorB42254)
        }
    }
}

// Preview of the DashBoardUIView
#Preview {
    DashBoardUIView()
}

