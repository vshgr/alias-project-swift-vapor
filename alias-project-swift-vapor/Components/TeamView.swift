//
//  TeamView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct TeamView: View {
    var buttonClicked: () -> Void

    var body: some View {
        Button {
            buttonClicked()
        } label: {
            VStack {
                Circle()
                    .fill(Color.random)
                    .frame(width: Constants.temCircleWH, height: Constants.temCircleWH)
                Text("1234")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
            }
        }
    }
}
