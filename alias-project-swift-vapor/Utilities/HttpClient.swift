import Foundation
import SwiftUI

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

enum HttpMethods: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

struct LoginResponse: Codable {
    let value: String
    let id: String
    let user: User
}


class HttpClient: ObservableObject {
        
    public init() {
    }
    
    static let shared = HttpClient()

    // Функция для сохранения токена авторизации в UserDefaults
    func saveAuthToken(token: String) {
        UserDefaults.standard.set(token, forKey: "AuthToken")
    }
    
    func saveUserID(userId: String) {
        UserDefaults.standard.set(userId, forKey: "UserID")
    }
    
    func saveUsername(username: String) {
        UserDefaults.standard.set(username, forKey: "Name")
    }

    // Функция для загрузки токена авторизации из UserDefaults
    func loadAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "AuthToken")
    }
    
    func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: "Name")
    }
    
    func loadUserID() -> String? {
        return UserDefaults.standard.string(forKey: "UserID")
    }
    
    // Функция для удаления токена авторизации из UserDefaults
    func logoutDefaults() {
        UserDefaults.standard.set(nil, forKey: "AuthToken")
        UserDefaults.standard.set(nil, forKey: "Name")
    }
    
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "AuthToken") != nil
    }


    func fetch<T: Codable>(url: URL, completion: @escaping ([T]?, Error?) -> Void) {
        var request = URLRequest(url: url)
        let token = loadAuthToken()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization":"Bearer \(token ?? "error")"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            let dataDecoded = try? decoder.decode([T].self, from: data)
            
            DispatchQueue.main.async {
                completion(dataDecoded, nil)
            }
        }
        
        task.resume()
    }
    
    func execute(url: URL, httpMethod: String, id: String) async throws -> Bool {
        let params = ["gameRoomId": id]
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        let token = loadAuthToken()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization":"Bearer \(token ?? "error")"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("error")
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        return true
    }
    
    func joinRoom(invCode: String, gameRoomId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let params = ["invitationCode": invCode, "gameRoomId": gameRoomId]
        let urlString = Constants.baseURL + GameRoomEndpoints.joinRoom
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let token = loadAuthToken()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token ?? "error")"
        ]
        
        // Конвертируем параметры запроса в JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(error))
        }
        
        // Отправляем запрос
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func sendDataCreateRoom(to url: URL, object: Room, httpMethod: String, completion: @escaping (Result<Room, Error>) -> Void) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        let token = loadAuthToken()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization":"Bearer \(token ?? "error")"
        ]
        request.httpBody = try? JSONEncoder().encode(object)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let room = Room(name: responseJSON["name"] as? String ?? "",
                                isPrivate: responseJSON["isPrivate"] as? Bool ?? false,
                                creator: responseJSON["creator"] as? UserId,
                                admin: responseJSON["admin"] as? UserId,
                                invCode: responseJSON["invitationCode"] as? String ?? "aa")
                
                completion(.success(room))
            }
        }
        
        task.resume()
    }
    
    func logout(completion: @escaping (Result<Bool,Error>) -> Void) {
        let urlString = Constants.baseURL + UserEndpoints.logout
        guard let url = URL(string: urlString) else {
            completion(.failure(HttpError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let token = loadAuthToken()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization":"Bearer \(token ?? "error")"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
        UserDefaults.standard.set(nil, forKey: "AuthToken")
        completion(.success(true))
    }

    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params = ["email": email, "password": password]
        
        let urlString = Constants.baseURL + UserEndpoints.login
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Конвертируем параметры запроса в JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(error))
        }
        
        // Отправляем запрос
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            // Проверяем наличие данных
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            // Парсим полученные данные
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let token = json?["value"] as? String {
                    self.saveUsername(username: json?["name"] as? String ?? "")
                    let userId = json?["user"] as? [String: Any]
                    self.saveUserID(userId: userId?["id"] as? String ?? "")
                    completion(.success(token))
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    func register(name: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params = ["name": name, "email": email, "password": password]
        let urlString = Constants.baseURL + UserEndpoints.register
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Конвертируем параметры запроса в JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(error))
        }
        
        // Отправляем запрос
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
                        
            self.login(email: email, password: password) { result in
                switch result {
                case .success(let token):
                    print("Авторизация и регистрация успешны! Токен: \(token)")
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                    print("Ошибка авторизации: \(error)")
                }
            }
        }
        
        task.resume()
    }
}
