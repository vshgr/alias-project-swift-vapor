//
//  RoomPage.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct RoomPage: View {
    @ObservedObject private var viewModel: RoomViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    init(viewModel: RoomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text(viewModel.room.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Text("room code: \(viewModel.roomCode)")
                TitleView(title: "Teams")
                    .padding(.top, Constants.smallPadding)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach (1..<3) { i in
                            TeamView() {
                                // TODO: обработать выбор команды
                            }
                        }
                        Button {
                            viewModel.isAddTeamPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 15, height: 15)
                        }
                        .alert("New team", isPresented: $viewModel.isAddTeamPresented, actions: {
                            TextField("team name...", text: $viewModel.teamName)
                            Button("Add", action: {
                                viewModel.addTeam()
                            })
                            Button("Cancel", role: .cancel, action: {})
                        }, message: {
                            Text("Please enter new team name.")
                        })
                    }
                }
                TitleView(title: "Participants")
                    .padding(.top, 20)
                ScrollView {
                    ForEach (1..<5) { i in
                        ParticipantView() {
                            viewModel.showingAlert = true
                        }
                        .padding(.bottom, 10)
                    }
                }
                
                HStack {
                    Spacer()
                    ButtonView(title: "start game", arrow: "right") {
                        
                    }
                }
                .padding(.top, Constants.smallPadding)
            }
            .alert("Actions", isPresented: $viewModel.showingAlert) {
                Button("Kick", role: .destructive) {
                    viewModel.kickMember()
                }
                Button("Make admin", role: .destructive) {
                    viewModel.changeAdmin()
                }
                Button("Cancel", role: .cancel) {}
            }
            .padding(.all, Constants.padding)
            .navigationBarItems(leading: ButtonView(title: "go back", arrow: "left") {
                appRouter.navigateTo(screen: .home)
            }, trailing: barItem)
        }
    }
    
    private var barItem: some View {
        HStack {
            Button {
                viewModel.isSettingsPagePresented = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.black)
            }
            Button {
                Task {
                    try await viewModel.deleteRoom()
                }
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.black)
            }
        }
        .navigationDestination(isPresented: $viewModel.isSettingsPagePresented) {
            SettingsView()
        }
    }
}
