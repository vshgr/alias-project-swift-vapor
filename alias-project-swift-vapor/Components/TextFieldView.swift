//
//  TextFieldView.swift
//  alias-project-swift-vapor
//
//  Created by Алиса Вышегородцева on 24.05.2023.
//

import SwiftUI

struct TextFieldView: View {
    private let hint: String
    @Binding private var text: String
    
    init(hint: String, text: Binding<String>) {
        self.hint = hint
        self._text = text
    }
    
    var body: some View {
        TextField(hint, text: $text)
            .textFieldStyle(DefaultTextFieldStyle())
            .padding(Constants.smallPadding)
            .border(.black)
    }
}
