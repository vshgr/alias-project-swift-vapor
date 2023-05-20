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
    @Published var isMainPagePresented: Bool = false
    
    func singInButtonClicked() {
        
    }
}
