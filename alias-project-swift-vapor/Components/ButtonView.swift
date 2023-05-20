//
//  ButtonView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var buttonClicked: (() -> Void)?
    
    var body: some View {
        Button {
            buttonClicked?()
        } label: {
            HStack(alignment: .center){
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
            }
        }
    }
}

struct ButtonViewpr: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "sign in")
    }
}

