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
    @Published var roomCode: Int = Int.random(in: 10000...99999)
    @Published var isSettingsPagePresented: Bool = false
    
    let room: Room
    
    init(room: Room){
        self.room = room
    }
    
    func addTeam() {
        
    }
    
    func kickMember() {
        
    }
    
    func changeAdmin() {
        
    }
    
    func deleteRoom() {
        
    }
}
