import Foundation

class MainPageViewModel: ObservableObject {
    
    @Published var publicRooms: [Room] = [.init(name: "Alias", invitationCode: "123", isPrivate: false, creator: User(name: "Yana", email: "wishnya@mail.ru", passwordHash: "aaaaaaaa"), admin: User(name: "Yana", email: "wishnya@mail.ru", passwordHash: "aaaaaaaa"), pointsPerWord: 3)]
    
    @Published var newRoomName: String = ""
    @Published var roomCode: String = ""
    @Published var password: String = ""
    @Published var roomTitle: String = ""
    @Published var isRoomPagePresented: Bool = false
    @Published var isAddRoomPresented: Bool = false
    
    public func fetchRooms() async throws {
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
    
    func createPublicRoomButtonClicked() async throws {
        let urlString = Constants.baseURL + Endpoints.rooms
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let room = Room(name: newRoomName, invitationCode: roomCode, isPrivate: false, creator: User(name: "yana", email: "wishnya@mail.ru", passwordHash: "aaaaa"), admin: User(name: "yana", email: "wishnya@mail.ru", passwordHash: "aaaaa"))
        
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func createPrivateRoomButtonClicked() {
        
    }
}
