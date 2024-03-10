import SwiftUI

/// Represents a view for displaying the QR code and attendance details for a user.
struct QRCodeView: View {
    /// View model for managing QR code related functionality.
    @StateObject private var viewModel = QRCodeViewModels()
    
    /// The user for whom the QR code is being displayed.
    var person: User
    
    var body: some View {
        VStack(alignment: .center) {
            // Header title view
            HeaderTitleView(text: "QR Code")
                .accessibilityIdentifier("back_qr_code")
            VStack {
                VStack(alignment: .center) {
                    // User's full name
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                    
                    // Text indicating the purpose of the QR code
                    Text("Attendance Code")
                        .modifier(PTSansRegularTextModifier(fontSize: 20))
                    
                    // Display QR code image if available
                    if let qrCodeDetails = viewModel.qrCodeDetails {
                        RemoteImage.RectangleImage(url: URL(string: qrCodeDetails.getQRCode))
                            .frame(width: 234, height: 234)
                    }
                }
                .padding(30)
                .modifier(Card())
                .padding(.top, 45)
                
                // Description about the QR code usage
                Text("This is your private code. Show this to your server so that we can understand you’ve arrived for your date. Thanks.")
                    .modifier(PTSansRegularTextModifier(fontSize: 20, textAlignment: .center))
                    .padding(.top, 15)
                    .padding([.leading, .trailing], 25)
                
                Spacer()
            }
            .modifier(SurfaceBackGround())
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Fetch QR code details on view appear
            viewModel.getQrCodeDetails(chatId: String(person.getID))
        }
    }
}

// Preview of the QRCodeView
#Preview {
    NavigationStack {
        QRCodeView(person: .init(id: 94, full_name: "Susan D. Fairchild", profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
}

// Preview with additional customizations
#Preview("Other", body: {
    NavigationStack {
        QRCodeView(person: .init(id: 94, full_name: "Susan D. Fairchild", profile_photo: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d"))
    }
})

