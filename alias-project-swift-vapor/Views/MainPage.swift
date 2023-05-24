//
//  MainPage.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct MainPage: View {
    
    @ObservedObject private var viewModel = MainPageViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading) {
                HStack(spacing: Constants.padding) {
                    TextFieldView(hint: "enter code...", text: $viewModel.roomCode)
                        .keyboardType(.numberPad)
                    ButtonView(title: "go") {
                        viewModel.enterRoomButtonClicked()
                    }
                }
                TitleView(title: "Open rooms")
                    .padding(.top , Constants.smallPadding)
                ScrollView {
                    ForEach (viewModel.publicRooms) { room in
                        RoomView(room: room, buttonClicked: {viewModel.isRoomPagePresented = true})
                            .navigationDestination(isPresented: $viewModel.isRoomPagePresented) {
                                RoomPage(viewModel: RoomViewModel(room: room))
                            }
                            .padding(.bottom, Constants.smallPadding)
                    }
                }
                
                HStack {
                    Spacer()
                    ButtonView(title: "create room") {
                        viewModel.isAddRoomPresented = true
                    }
                    .alert("New room", isPresented: $viewModel.isAddRoomPresented, actions: {
                        TextField("room name...", text: $viewModel.newRoomName)
                        Button("Create private room", action: {
                            viewModel.createPrivateRoomButtonClicked()
                        })
                        Button("Create public room", action: {
                            Task {
                                do {
                                    try await viewModel.createPublicRoomButtonClicked()
                                } catch {
                                    print(error)
                                }
                            }
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter new room name.")
                    })
                }
                .padding(.top, Constants.smallPadding)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
        Button(action: {
            viewModel.logoutButtonClicked()
        }, label: {
            HStack {
                Text("logout")
                Image(systemName: "rectangle.portrait.and.arrow.forward")
            }
            .foregroundColor(.black)
        }))
        .navigationDestination(isPresented: $viewModel.isLoggedOut) {
            WelcomeView()
        }
        .textFieldStyle(.roundedBorder)
        .padding(.all, Constants.padding)
        .onAppear() {
            Task {
                do {
                    try await viewModel.fetchRooms()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct MainPagepr: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
