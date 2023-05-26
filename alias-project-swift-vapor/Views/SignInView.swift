//
//  AuthorisationView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject private var viewModel = SingInViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading) {
                Spacer()
                
                TextFieldView(hint: "email...", text: $viewModel.email)
                TextFieldView(hint: "password...", text: $viewModel.password)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack (alignment: .trailing, spacing: Constants.smallPadding) {
                        ButtonView(title: "sign in", arrow: "right") {
                            viewModel.singInButtonClicked()
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
        .navigationTitle("Authorisation")
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, Constants.padding)
    }
    
}

struct SignInViewpr: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
