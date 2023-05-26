import Foundation

public class Room: Identifiable, Codable, ObservableObject {
    
    public var id: String?
    public var name: String
    public var creator: UserId?
    public var isPrivate: Bool
    public var admin: UserId?
    public var invitationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, isPrivate, invitationCode
    }
    
    public init(name: String, isPrivate: Bool, creator: UserId?, admin: UserId?, invCode: String?) {
        self.name = name
        self.isPrivate = isPrivate
        self.creator = creator
        self.admin = admin
        self.invitationCode = invCode
    }
}
