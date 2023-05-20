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
                HStack {
                    TextField("enter code...", text: $viewModel.roomCode)
                        .keyboardType(.numberPad)
                    ButtonView(title: "enter room") {
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
                            viewModel.createPublicRoomButtonClicked()
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
    }
}

struct MainPagepr: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
