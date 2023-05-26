//
//  ButtonView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    private let arrow: String
    var buttonClicked: () -> Void
    
    init(title: String, arrow: String, buttonClicked: @escaping () -> Void) {
        self.title = title
        self.arrow = arrow
        self.buttonClicked = buttonClicked
    }
    
    var body: some View {
        Button {
            buttonClicked()
        } label: {
            HStack(alignment: .center){
                if arrow == "left" {
                    Image(systemName: "arrow.\(arrow)")
                        .foregroundColor(.black)
                    Text(title)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                } else {
                    Text(title)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                    Image(systemName: "arrow.\(arrow)")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

