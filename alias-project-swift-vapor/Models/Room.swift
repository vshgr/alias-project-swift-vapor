import Foundation

public class Room: Identifiable, Codable, ObservableObject {
    
    public var id: String?
    public var name: String
    public var creator: String?
    public var isPrivate: Bool
    public var admin: String?
    public var invitationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, isPrivate, invitationCode
    }
    
    public init(name: String, isPrivate: Bool, creator: String?, admin: String?, invCode: String?) {
        self.name = name
        self.isPrivate = isPrivate
        self.creator = creator
        self.admin = admin
        self.invitationCode = invCode
    }
}
