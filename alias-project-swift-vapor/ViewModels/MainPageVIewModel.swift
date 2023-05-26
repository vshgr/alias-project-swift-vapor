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
    
    public func fetchRooms(completion: @escaping ([Room]) -> Void) async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.getAllRooms
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        await HttpClient.shared.fetch(url: url) { [weak self] (rooms, error) in
            self?.publicRooms = rooms ?? [Room]()
            completion(self?.publicRooms ?? [Room]())
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
        
        guard let username = HttpClient.shared.loadUserName() else {
            print("error")
            return
        }
        
        let room = Room(name: newRoomName, creator: username, isPrivate: false, admin: username)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func createPrivateRoomButtonClicked() async throws {
        let urlString = Constants.baseURL + GameRoomEndpoints.createRoom
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        guard let username = HttpClient.shared.loadUserName() else {
            print("error")
            return
        }
        
        let room = Room(name: newRoomName, creator: username, isPrivate: true, admin: username)
                
        try await HttpClient.shared.sendData(to: url,
                                             object: room,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func logoutButtonClicked() {
        HttpClient.shared.logout { result in
            switch result {
            case .success:
                self.isLoggedOut = true
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        isAlertPresented = !isLoggedOut
    }
}
