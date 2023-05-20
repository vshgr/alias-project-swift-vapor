//
//  AuthorisationView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading) {
                Spacer()
                
                TextField("username...", text: $viewModel.username)
                TextField("email...", text: $viewModel.email)
                SecureField("password...", text: $viewModel.password)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack (alignment: .trailing, spacing: Constants.padding) {
                        ButtonView(title: "register") {
                            viewModel.isMainPagePresented = true
                            viewModel.registerButtonClicked()
                        }
                        .navigationDestination(isPresented: $viewModel.isMainPagePresented) {
                            MainPage()
                        }
                    }
                }
                .padding(.bottom, Constants.padding)
            }
        }
        .navigationTitle("Registration")
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, Constants.padding)
    }
    
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
