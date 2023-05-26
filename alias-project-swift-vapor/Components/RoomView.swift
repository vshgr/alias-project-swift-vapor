//
//  RoomView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct RoomView: View {
    private let room: Room
    private let buttonClicked: () -> Void
    private let color: Color = Color.random
    
    init(room: Room, buttonClicked: @escaping () -> Void) {
        self.room = room
        self.buttonClicked = buttonClicked
    }
    
    var body: some View {
        Button {
            buttonClicked()
        } label: {
            HStack(alignment: .center){
                Circle()
                    .fill(.green)
                    .frame(width: Constants.smallPadding, height: Constants.smallPadding)
                Text(room.name)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
            }
            .padding()
        }
        .background(.gray.opacity(0.1))
    }
}
