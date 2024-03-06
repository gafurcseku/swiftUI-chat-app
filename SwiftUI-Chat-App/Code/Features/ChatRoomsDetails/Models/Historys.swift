//
//  Historys.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation
struct Historys : Codable {
    let status : Bool?
    let data : HistoryData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(HistoryData.self, forKey: .data)
    }

}

extension Historys {
    var getStatus:Bool {
        guard let status = self.status else { return false }
        return true
    }
    
}
