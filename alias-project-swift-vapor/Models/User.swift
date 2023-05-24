import Foundation

public struct User: Identifiable, Codable {
    
    public var id: UUID?
    public var name: String
    public var email: String
    var passwordHash: String
}
