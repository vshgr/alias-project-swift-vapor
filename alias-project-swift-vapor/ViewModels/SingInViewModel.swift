//
//  SingInViewModel.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import Foundation

class SingInViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isAlertPresented: Bool = false
    @Published var errorMessage: String = ""
    @Published var isMainPagePresented: Bool = false
    
    func login() async throws {
        let urlString = Constants.baseURL + UserEndpoints.login
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let user = UserLogin(email: email, password: password)
        
        try await  HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func singInButtonClicked() {
        Task {
            do {
                try await login()
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
