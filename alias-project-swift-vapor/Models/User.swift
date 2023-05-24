import Foundation

public struct User: Identifiable, Codable {
    
    public var id: UUID?
    public var name: String
    public var email: String
    public var password_hash: String
}

public struct UserLogin: Codable {
    public var email: String
    public var password: String
}
