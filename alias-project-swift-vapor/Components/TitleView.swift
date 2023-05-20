//
//  TitleView.swift
//  Alias
//
//  Created by Алиса Вышегородцева on 23.03.2023.
//

import SwiftUI

struct TitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20))
            .fontWeight(.bold)
    }
}

struct TitleViewpr: PreviewProvider {
    static var previews: some View {
        TitleView(title: "room #1")
    }
}
