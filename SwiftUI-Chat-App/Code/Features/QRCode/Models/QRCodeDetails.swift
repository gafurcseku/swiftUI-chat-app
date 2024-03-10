import Foundation

import Foundation
struct QRCodeDetails : Codable {
    let qr_code : String?
    let match_id : Int?

    enum CodingKeys: String, CodingKey {

        case qr_code = "qr_code"
        case match_id = "match_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        qr_code = try values.decodeIfPresent(String.self, forKey: .qr_code)
        match_id = try values.decodeIfPresent(Int.self, forKey: .match_id)
    }

}

extension QRCodeDetails {
    
    var getQRCode: String {
            guard let qrCode = qr_code else {
                return "N/A"
            }
            return qrCode
        }
        
        var getMatchID: Int {
            guard let matchID = match_id else {
                return 0
            }
            return matchID
        }
}
