import Foundation
struct Rooms : Codable {
    let status : Bool?
    let data : RoomsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(RoomsData.self, forKey: .data)
    }

}

extension Rooms {
    var getStatus:Bool {
        guard let status = self.status else { return false }
        return true
    }
    
}
