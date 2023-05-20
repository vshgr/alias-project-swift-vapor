//
//  MainPageVIewModel.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import Foundation

class MainPageViewModel: ObservableObject {
    
    @Published var publicRooms: [Room] = [.init(id: "123", name: "Hello world")]
    @Published var newRoomName: String = ""
    @Published var roomCode: String = ""
    @Published var password: String = ""
    @Published var roomTitle: String = ""
    @Published var isRoomPagePresented: Bool = false
    @Published var isAddRoomPresented: Bool = false
    
    func enterRoomButtonClicked() {
        
    }
    
    func roomClicked() {
        
    }
    
    func createPublicRoomButtonClicked() {
        
    }
    
    func createPrivateRoomButtonClicked() {
        
    }
}
