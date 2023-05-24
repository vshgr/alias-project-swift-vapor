import Foundation

public struct Room: Identifiable, Codable {
    
    public var id: UUID?
    public var name: String
    var invitationCode: String
    var isPrivate: Bool
    var creator: User
    var admin: User
    var pointsPerWord: Int = 5
}
