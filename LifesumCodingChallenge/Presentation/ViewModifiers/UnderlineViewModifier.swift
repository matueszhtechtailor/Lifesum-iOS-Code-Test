//
//  UnderlineViewModifier.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
import SwiftUI

struct UnderlineViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .offset(y: 4),
                alignment: .bottom
            )
    }
}

extension View {
    func underline() -> some View {
        self.modifier(UnderlineViewModifier())
    }
}
