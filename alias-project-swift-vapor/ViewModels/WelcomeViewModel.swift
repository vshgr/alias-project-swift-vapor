//
//  WelcomeViewModel.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isRegisterPresented: Bool = false
    @Published var isLogInPresented: Bool = false
}
