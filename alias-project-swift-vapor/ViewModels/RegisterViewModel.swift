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
    
    func registerButtonClicked() {
        HttpClient.shared.removeAuthToken()
        HttpClient.shared.register(name: username, email: email, password: password) { result in
            switch result {
            case .success(let token):
                HttpClient.shared.saveAuthToken(token: token)
                DispatchQueue.main.async {
                    self.isMainPagePresented = true
                }
            case .failure(let error):
                print("Ошибка регистрации: \(error)")
                DispatchQueue.main.async {
                    self.isAlertPresented = true
                    self.errorMessage = "Ошибка регистрации: \(error)"
                }
            }
        }
    }
}
