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
    
    init(id: Int? = nil, channel_name: String? = nil, status: String? = nil, participants: String? = nil, created_at: Int? = nil, blocked_by: String? = nil, full_name: String? = nil, profile_photo: String? = nil, gender: String? = nil, last_message: String? = nil) {
        self.id = id
        self.channel_name = channel_name
        self.status = status
        self.participants = participants
        self.created_at = created_at
        self.blocked_by = blocked_by
        self.full_name = full_name
        self.profile_photo = profile_photo
        self.gender = gender
        self.last_message = last_message
    }
    
}

extension User {
    var getID: Int {
        guard let id = id else {
            return 0
        }
        return id
    }
    
    var getChannelName: String {
        guard let channelName = channel_name else {
            return "N/A"
        }
        return channelName
    }
    
    var getStatus: String {
        guard let status = status else {
            return "N/A"
        }
        return status
    }
    
    var getParticipants: String {
        guard let participants = participants else {
            return "N/A"
        }
        return participants
    }
    
    var getBlockedBy: String {
        guard let blockedBy = blocked_by else {
            return "N/A"
        }
        return blockedBy
    }
    
    var getFullName: String {
        guard let fullName = full_name else {
            return "N/A"
        }
        return fullName
    }
    
    var getProfilePhoto: String {
        guard let profilePhoto = profile_photo else {
            return "N/A"
        }
        return profilePhoto+".jpeg"
    }
    
    var getGender: String {
        guard let gender = gender else {
            return "N/A"
        }
        return gender
    }
    
    var getLastMessage: String {
        guard let lastMessage = last_message else {
            return "N/A"
        }
        return lastMessage
    }
}
