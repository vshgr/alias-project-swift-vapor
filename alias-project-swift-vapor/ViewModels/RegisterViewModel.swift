//
//  RegisterViewModel.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isAlertPresented: Bool = false
    @Published var errorMessage: String = ""
    @Published var isMainPagePresented: Bool = false
    
    func register() async throws {
        let urlString = Constants.baseURL + UserEndpoints.register
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let user = User(name: username, email: email, password: password)
        
        try await  HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
    }
    
    
    func registerButtonClicked() {
        Task {
            do {
                try await register()
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isMainPagePresented = false
                    self.isAlertPresented = true
                }
            }
            DispatchQueue.main.async {
                self.isMainPagePresented = true
            }
        }
    }
}
