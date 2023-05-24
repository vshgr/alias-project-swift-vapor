import Foundation

class MainPageViewModel: ObservableObject {
    
    @Published var publicRooms: [Room] = [.init(name: "test", invitation_code: "123", is_private: false, creator_id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000") ?? UUID(), admin_id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000") ?? UUID())]
    
    @Published var newRoomName: String = ""
    @Published var roomCode: String = ""
    @Published var password: String = ""
    @Published var roomTitle: String = ""
    @Published var isRoomPagePresented: Bool = false
    @Published var isAddRoomPresented: Bool = false
    
    public func fetchRooms() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.getAllRooms
        
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
    
    func createPublicRoomButtonClicked() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.createRoom
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let room = Room(name: "yana", invitation_code: "123", is_private: false, creator_id: UUID(uuidString: "B0D52280-4A9B-47AA-9AF0-C529EC786ED8") ?? UUID(), admin_id: UUID(uuidString: "B0D52280-4A9B-47AA-9AF0-C529EC786ED8") ?? UUID())
        
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func createPrivateRoomButtonClicked() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.createRoom
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let room = Room(name: "yana", invitation_code: "123", is_private: true, creator_id: UUID(uuidString: "B0D52280-4A9B-47AA-9AF0-C529EC786ED8") ?? UUID(), admin_id: UUID(uuidString: "B0D52280-4A9B-47AA-9AF0-C529EC786ED8") ?? UUID())
        
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
}
