import Foundation

/// Service class responsible for fetching QR code details from the API.
class QRCodeService {
    
    /// Fetches QR code details for the specified chat ID.
    /// - Parameters:
    ///   - chatId: The ID of the chat room.
    ///   - completion: A closure to be executed when the QR code details retrieval is completed. It takes a result of type `ResponseHandler<QRCodeDetails>`, indicating success or failure.
    func getQrCode(chatId: String, completion: @escaping ResponseHandler<QRCodeDetails>) {
        // Make an API call to fetch QR code details
        APIClient.shared.objectAPICall(apiEndPoint: QRCodeAPIEndPoint.getQRCode(chatId: chatId), modelType: QRCode.self) { result in
            switch result {
            case .success(let qrCode):
                // Check if the API call was successful and QR code data is available
                if qrCode.getStatus {
                    if let qrDetails = qrCode.data {
                        // If QR code details are available, pass them to the completion handler as a success response
                        completion(Response.success(qrDetails))
                    } else {
                        // If no QR code details are available, pass failure response with appropriate message and code
                        completion(Response.failure("No Data", 201))
                    }
                }
            case .failure(let error):
                // If API call fails, pass failure response with error details
                completion(Response.failure("Chat Api error -\(error.0)", error.0))
            }
        }
    }
}

