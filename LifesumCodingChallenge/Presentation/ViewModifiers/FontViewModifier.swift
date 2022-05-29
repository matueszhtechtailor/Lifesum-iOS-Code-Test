//
//  FontViewModifier.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 29/05/2022.
//

import Foundation
import SwiftUI

struct FontViewModifier: ViewModifier {
    private let size: CGFloat

    init(size: CGFloat) {
        self.size = size
    }

    func body(content: Content) -> some View {
        content
            .font(.custom("Avenir", size: size))
    }
}

extension View {
    func defaultFont(size: CGFloat) -> some View {
        self.modifier(FontViewModifier(size: size))
    }
}
