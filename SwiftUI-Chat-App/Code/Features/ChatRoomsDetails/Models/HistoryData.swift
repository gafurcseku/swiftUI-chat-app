//
//  HistoryData.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//

import Foundation
struct HistoryData : Codable {
    let data : [Messages]?
    let has_next : Bool?
    let has_prev : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case has_next = "has_next"
        case has_prev = "has_prev"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Messages].self, forKey: .data)
        has_next = try values.decodeIfPresent(Bool.self, forKey: .has_next)
        has_prev = try values.decodeIfPresent(Bool.self, forKey: .has_prev)
    }

}

extension HistoryData {
    var getData:[Messages] {
        guard let data = self.data else { return [] }
        return data
    }
}
