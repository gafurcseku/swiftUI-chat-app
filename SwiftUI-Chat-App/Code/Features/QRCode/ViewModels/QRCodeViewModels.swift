import Foundation

/// View model class for managing QR code related functionality.
class QRCodeViewModels: BaseViewModel {
    
    /// Published property holding the QR code details.
    @Published var qrCodeDetails: QRCodeDetails? = nil
    
    /// Fetches QR code details for the specified chat ID.
    /// - Parameter chatId: The ID of the chat room.
    func getQrCodeDetails(chatId: String) {
        QRCodeService().getQrCode(chatId: chatId) { result in
            switch result {
            case .success(let qr):
                // Update qrCodeDetails with fetched QR code details
                self.qrCodeDetails = qr
            case .failure(_, _):
                // Handle failure if needed
                break
            }
        }
    }
}

