import Foundation

public struct Room: Identifiable, Codable {
    
    public var id: UUID?
    public var name: String
    public var invitation_code: String
    public var is_private: Bool
    public var creator_id: UUID
    public var admin_id: UUID
    public var points_per_word: Int = 5
}
