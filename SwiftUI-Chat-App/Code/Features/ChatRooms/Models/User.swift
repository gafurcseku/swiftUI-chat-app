import Foundation
struct User : Codable {
    let id : Int?
    let channel_name : String?
    let status : String?
    let participants : String?
    let created_at : Int?
    let blocked_by : String?
    let full_name : String?
    let profile_photo : String?
    let gender : String?
    let last_message : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case channel_name = "channel_name"
        case status = "status"
        case participants = "participants"
        case created_at = "created_at"
        case blocked_by = "blocked_by"
        case full_name = "full_name"
        case profile_photo = "profile_photo"
        case gender = "gender"
        case last_message = "last_message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        channel_name = try values.decodeIfPresent(String.self, forKey: .channel_name)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        participants = try values.decodeIfPresent(String.self, forKey: .participants)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
        blocked_by = try values.decodeIfPresent(String.self, forKey: .blocked_by)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        profile_photo = try values.decodeIfPresent(String.self, forKey: .profile_photo)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        last_message = try values.decodeIfPresent(String.self, forKey: .last_message)
    }

}
