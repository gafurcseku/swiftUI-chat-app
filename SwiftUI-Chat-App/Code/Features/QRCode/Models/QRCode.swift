//
//  QRCode.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation
struct QRCode : Codable {
    let status : Bool?
    let data : QRCodeDetails?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(QRCodeDetails.self, forKey: .data)
    }

}

extension QRCode {
    var getStatus:Bool {
        guard let status = self.status else { return false }
        return status
    }
}
