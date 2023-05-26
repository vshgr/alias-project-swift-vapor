//
//  alias_project_swift_vaporApp.swift
//  alias-project-swift-vapor
//
//  Created by Алиса Вышегородцева on 20.05.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        switch appRouter.currentScreen {
        case .welcome:
            if HttpClient.shared.isAuthenticated() {
                MainPage()
            } else {
                WelcomeView()
            }
        case .home:
            MainPage()
        case .detail(item: let item):
            RoomPage(viewModel: RoomViewModel(room: item))
        }
    }
}

@main
struct alias_project_swift_vaporApp: App {
    let appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appRouter)
        }
    }
}

