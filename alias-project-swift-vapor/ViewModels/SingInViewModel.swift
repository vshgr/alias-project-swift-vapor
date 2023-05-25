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
    
    
    func singInButtonClicked() {
        HttpClient.shared.removeAuthToken()
        HttpClient.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                print("Авторизация успешна! Токен: \(token)")
                HttpClient.shared.saveAuthToken(token: token)
                DispatchQueue.main.async {
                    self.isMainPagePresented = true
                }
            case .failure(let error):
                print("Ошибка авторизации: \(error)")
                DispatchQueue.main.async {
                    self.isAlertPresented = true
                    self.errorMessage = "Ошибка авторизации: \(error)"
                }
            }
        }
    }
}
