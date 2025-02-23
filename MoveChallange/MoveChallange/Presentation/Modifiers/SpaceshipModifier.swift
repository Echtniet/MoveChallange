//
//  SpaceshipModifier.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct SpaceshipModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color.gray.opacity(0.8),
                    Color.black.opacity(0.9)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(LinearGradient(gradient: Gradient(colors: [
                        Color.gray.opacity(0.8),
                        Color.white.opacity(0.6),
                        Color.gray.opacity(0.3)
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.6), lineWidth: 1)
                    .blur(radius: 2)
            )
            .shadow(color: Color.gray.opacity(0.9), radius: 5, x: 2, y: 2)
    }
}

extension View {
    public func spaceship() -> some View {
        self.modifier(SpaceshipModifier())
    }
}
