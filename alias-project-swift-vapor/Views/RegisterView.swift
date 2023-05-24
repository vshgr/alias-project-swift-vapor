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
                
                TextFieldView(hint: "username...", text: $viewModel.username)
                TextFieldView(hint: "email...", text: $viewModel.email)
                TextFieldView(hint: "password...", text: $viewModel.password)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack (alignment: .trailing, spacing: Constants.padding) {
                        ButtonView(title: "register") {
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
        .alert(isPresented: $viewModel.isAlertPresented) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
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
