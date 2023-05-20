//
//  ParticipantView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//
import SwiftUI

struct ParticipantView: View {
    var buttonClicked: (() -> Void)?
    let color: Color = Color.random
    
    var body: some View {
        Button {
            buttonClicked?()
        } label: {
            HStack(alignment: .center){
                Circle()
                    .fill(.green)
                    .frame(width: Constants.padding, height: Constants.padding)
                Text("капибара")
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .background(.green.opacity(0.1))
    }
}

struct ParticipantViewpr: PreviewProvider {
    static var previews: some View {
        ParticipantView()
    }
}
