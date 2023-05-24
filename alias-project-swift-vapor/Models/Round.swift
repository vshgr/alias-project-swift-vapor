import Foundation

public struct Round: Identifiable, Codable {
    public var id: UUID?
    var gameRoom: Room
    var startTime: Date
    var endTime: Date?
    var state: String
}
