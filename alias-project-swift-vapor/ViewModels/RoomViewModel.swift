//
//  RoomViewModel.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import Foundation

class RoomViewModel: ObservableObject {
    
    @Published var teamName: String = ""
    @Published var showingAlert: Bool = false
    @Published var isAddTeamPresented: Bool = false
    @Published var roomCode: String = ""
    @Published var isSettingsPagePresented: Bool = false
    
    let room: Room
    
    init(room: Room) {
        self.room = room
        self.roomCode = room.invitationCode ?? "aa"
    }
    
    func addTeam() {
        
    }
    
    func joinRoom(room: Room) {
    }
    
    func kickMember() {
        
    }
    
    func changeAdmin() {
        
    }
    
    func deleteRoom() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.closeRoom
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        HttpClient.shared.deleteRoomByID(roomID: room.id ?? "", url: url)
//        if !(try await HttpClient.shared.execute(url: url,
//                                                 httpMethod: HttpMethods.POST.rawValue, id: room.id ?? "")) {
//            print("error deleting")
//        }
    }
}
