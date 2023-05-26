import Foundation

public enum Constants {
    public static let padding: CGFloat = 30
    public static let smallPadding: CGFloat = 15
    public static let temCircleWH: CGFloat = 60
    
    public static let baseURL: String = "https://9db8-89-175-18-189.ngrok-free.app/"
}

public enum GameRoomEndpoints {
    public static let getAllRooms = "game-rooms/list-all"
    public static let createRoom = "game-rooms/create"
    public static let joinRoom = "game-rooms/join-room"
    public static let changeRoomSettings = "game-rooms/change-setting"
    public static let getRoomMembers = "game-rooms/list-members"
    public static let leaveRoom = "game-rooms/leave-room"
    public static let closeRoom = "game-rooms/close-room"
    public static let kickRoomParticipant = "game-rooms/kick-participant"
    public static let passAdminStatus = "game-rooms/pass-admin-status"
}

public enum TeamEndpoints {
    public static let getAllTeams = "teams/list-teams"
    public static let createTeam = "teams/create-team"
    public static let joinTeam = "teams/join-team"
    public static let leaveTeam = "teams/leave-team"
    public static let closeTeam = "teams/close-team"
}

public enum RoundEndpoints {
    public static let startRound = "round/start"
    public static let pauseRound = "round/pause"
}

public enum UserEndpoints {
    public static let register = "users/register"
    public static let login = "users/login"
    public static let profile = "users/profile"
    public static let logout = "users/logout"
}
