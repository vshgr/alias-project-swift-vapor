import Foundation

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

class HttpClient: ObservableObject {
    
    public var token: String
    
    public init() {
        token = "KLj1c1WedW7on2E/wIH5vwNcynYYTCOMqgr8+9zAdfs="
    }
    
    static let shared = HttpClient()
    
    //    func fetch<T: Codable>(url: URL) async throws -> [T] {
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //
    //        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
    //            throw HttpError.badResponse
    //        }
    //
    //        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
    //            throw HttpError.errorDecodingData
    //        }
    //        return object
    //    }
    
    
    func fetch<T: Codable>(url: URL, completion: @escaping ([T]?, Error?) -> Void) async {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization":"Bearer \(token)"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            print(String(data: data, encoding: String.Encoding.utf8) ?? "")
            
            let decoder = JSONDecoder()
            
            let dataDecoded = try? decoder.decode([T].self, from: data)
            print("а вот данные \(String(describing: dataDecoded)) они")
            DispatchQueue.main.async {
                completion(dataDecoded, nil)
            }
        }.resume()
    }
    
    func execute(url: URL, httpMethod: String) async throws -> Bool {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        return true
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONEncoder().encode(object)
        print(String(decoding: request.httpBody!, as: UTF8.self))
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print((response as? HTTPURLResponse)?.statusCode ?? 0)
            throw HttpError.badResponse
        }
    }
}
