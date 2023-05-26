//
//  MainPage.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct MainPage: View {
    
    @ObservedObject private var viewModel = MainPageViewModel()
    @State private var rooms: [Room] = [Room]()
    @EnvironmentObject var appRouter: AppRouter
    
    public init(viewModel: MainPageViewModel = MainPageViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading) {
                    HStack(spacing: Constants.padding) {
                        TextFieldView(hint: "enter code...", text: $viewModel.roomCode)
                            .keyboardType(.numberPad)
                        ButtonView(title: "go", arrow: "right") {
                            viewModel.enterRoomButtonClicked()
                        }
                    }
                    TitleView(title: "Open rooms")
                        .padding(.top , Constants.smallPadding)
                    ScrollView {
                        ForEach (viewModel.publicRooms) { room in
                            RoomView(room: room, buttonClicked: {
                                appRouter.goToDetails(item: room)
                            })
                            .padding(.bottom, Constants.smallPadding)
                        }
                    }
                    .refreshable {
                        viewModel.fetchRooms()
                    }
                    
                    HStack {
                        Button(action: {
                            viewModel.logoutButtonClicked()
                            appRouter.navigateTo(screen: .welcome)
                        }, label: {
                            HStack {
                                Text("logout")
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                            }
                            .foregroundColor(.black)
                        })
                        Spacer()
                        ButtonView(title: "create room", arrow: "right") {
                            viewModel.isAddRoomPresented = true
                        }
                        .alert("New room", isPresented: $viewModel.isAddRoomPresented, actions: {
                            TextField("room name...", text: $viewModel.newRoomName)
                            Button("Create private room", action: {
                                Task {
                                    do {
                                        try await viewModel.createPrivateRoomButtonClicked()
                                    } catch {
                                        print(error)
                                    }
                                }
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
            .textFieldStyle(.roundedBorder)
            .padding(.all, Constants.padding)
            .onAppear() {
                viewModel.fetchRooms()
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct MainPagepr: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
