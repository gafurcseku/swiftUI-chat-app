import Foundation
struct RoomsData : Codable {
    let data : [User]?
    let has_next : Bool?
    let has_prev : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case has_next = "has_next"
        case has_prev = "has_prev"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([User].self, forKey: .data)
        has_next = try values.decodeIfPresent(Bool.self, forKey: .has_next)
        has_prev = try values.decodeIfPresent(Bool.self, forKey: .has_prev)
    }

}

extension RoomsData {
    var getData:[User] {
        guard let data = self.data else { return [] }
        return data
    }
}
