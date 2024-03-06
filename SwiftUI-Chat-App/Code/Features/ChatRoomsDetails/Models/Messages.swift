//
//  Messages.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 7/3/24.
//


import Foundation
struct Messages : Codable {
    let id : Int?
    let body : String?
    let sender : Int?
    let chat_id : Int?
    let chat_type : String?
    let created_at : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case body = "body"
        case sender = "sender"
        case chat_id = "chat_id"
        case chat_type = "chat_type"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        body = try values.decodeIfPresent(String.self, forKey: .body)
        sender = try values.decodeIfPresent(Int.self, forKey: .sender)
        chat_id = try values.decodeIfPresent(Int.self, forKey: .chat_id)
        chat_type = try values.decodeIfPresent(String.self, forKey: .chat_type)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
    }

}
