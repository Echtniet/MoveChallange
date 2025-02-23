//
//  AtmosphereModifier.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct AtmosphereModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(LinearGradient(gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.cyan.opacity(0.5),
                        Color.clear
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 5)
                    .blur(radius: 5)
            )
            .shadow(color: Color.blue.opacity(0.6), radius: 10)

    }
}

extension View {
    public func atmosphere() -> some View {
        self.modifier(AtmosphereModifier())
    }
}
