import Foundation

class MainPageViewModel: ObservableObject {
    
    @Published var publicRooms: [Room] = []
    
    @Published var newRoomName: String = ""
    @Published var roomCode: String = ""
    @Published var password: String = ""
    @Published var roomTitle: String = ""
    @Published var isAlertPresented: Bool = false
    @Published var isLoggedOut: Bool = false
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
        
        let room = Room(name: newRoomName, invitationCode: roomCode, isPrivate: false, creator: User(name: "yana", email: "wishnya@mail.ru", password: "aaaaa"), admin: User(name: "yana", email: "wishnya@mail.ru", password: "aaaaa"))
        
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func createPrivateRoomButtonClicked() {
        
    }
    
    func logout() async throws {
        let urlString = Constants.baseURL + Endpoints.users + "/logout"
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        isLoggedOut = try await HttpClient.shared.execute(url: url, httpMethod: HttpMethods.POST.rawValue)
        isAlertPresented = !isLoggedOut
    }
    
    func logoutButtonClicked() {
        
    }
}
