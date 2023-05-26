//
//  Router.swift
//  alias-project-swift-vapor
//
//  Created by Алиса Вышегородцева on 26.05.2023.
//

import Foundation

class AppRouter: ObservableObject {
    enum Screens {
        case welcome
        case home
        case detail(item: Room)
    }
    
    @Published var currentScreen: Screens = .welcome
    
    func navigateTo(screen: Screens) {
        currentScreen = screen
    }
    
    func goToDetails(item: Room) {
        currentScreen = .detail(item: item)
    }
}
