import Foundation

public class Room: Identifiable, Codable, ObservableObject {
    
    public var id: String?
    public var name: String
    public var creator: String
    public var isPrivate: Bool
    public var admin: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, isPrivate, creator, admin
    }
    
    public init(name: String, creator: String, isPrivate: Bool, admin: String) {
        self.name = name
        self.creator = creator
        self.isPrivate = isPrivate
        self.admin = admin
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        creator = try values.decode(String.self, forKey: .creator)
        admin = try values.decode(String.self, forKey: .admin)
        name = try values.decode(String.self, forKey: .name)
        isPrivate = try values.decode(Bool.self, forKey: .isPrivate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(isPrivate, forKey: .isPrivate)
        try container.encode(admin, forKey: .admin)
        try container.encode(creator, forKey: .creator)
    }
}
