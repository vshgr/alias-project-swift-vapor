import Foundation

public struct User: Identifiable, Codable {
    
    public var id: UUID?
    public var name: String
    public var email: String
    public var password: String
}

public struct UserLogin: Codable {
    public var email: String
    public var password: String
}

public struct UserId: Codable {
    public var id: String
}
