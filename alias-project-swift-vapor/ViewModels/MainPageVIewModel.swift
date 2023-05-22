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
    
    func fetchRooms() async throws {
        let urlString = Constants.baseURL + Endpoints.rooms
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let roomResponse: [Room] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.publicRooms = roomResponse
        }
    }
    
    func enterRoomButtonClicked() {
        
    }
    
    func roomClicked() {
        
    }
    
    func createPublicRoomButtonClicked() {
        
    }
    
    func createPrivateRoomButtonClicked() {
        
    }
}
