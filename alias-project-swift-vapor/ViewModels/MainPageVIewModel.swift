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
        let urlString = Constants.baseURL + GameRoomEndpoints.getAllRooms
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        do {
            try await HttpClient.shared.fetch(url: url) { (rooms) in
                self.publicRooms = rooms
            }
            print("хуйхуйхуй\(publicRooms) я тут")
        } catch {
            print(error)
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

        let room = Room(name: newRoomName, creator: "ya", isPrivate: false, admin: "ya")

        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func createPrivateRoomButtonClicked() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.createRoom

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }

        let room = Room(name: newRoomName, creator: "ya", isPrivate: true, admin: "ya")

        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func logout() async throws {
        let urlString = Constants.baseURL + UserEndpoints.logout
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        isLoggedOut = try await HttpClient.shared.execute(url: url, httpMethod: HttpMethods.POST.rawValue)
        isAlertPresented = !isLoggedOut
    }
    
    func logoutButtonClicked() {
        Task {
            do {
                try await logout()
            } catch {
                
            }
            DispatchQueue.main.async {
                self.isLoggedOut = true
            }
        }
    }
}
