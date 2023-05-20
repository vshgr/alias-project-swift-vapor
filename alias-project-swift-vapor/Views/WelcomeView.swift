//
//  WelcomeView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 24.03.2023.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack (alignment: .leading, spacing: Constants.smallPadding) {
                        Spacer()
                        ButtonView(title: "sign in") {
                            viewModel.isLogInPresented = true
                        }
                        .navigationDestination(isPresented: $viewModel.isLogInPresented) {
                                SignInView()
                            }
                        
                        ButtonView(title: "register") {
                            viewModel.isRegisterPresented = true
                        }
                        .navigationDestination(isPresented: $viewModel.isRegisterPresented) {
                                RegisterView()
                            }
                    }
                }
                .padding(.bottom, Constants.padding)
            }
            .padding(.horizontal, Constants.padding)
        }
    }
}

struct WelcomeViewpr: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
