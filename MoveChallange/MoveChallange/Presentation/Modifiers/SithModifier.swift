//
//  SithModifier.swift
//  MoveChallange
//
//  Created by Clinton on 21/02/2025.
//

import SwiftUI

struct SithModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color.black,
                    Color.gray.opacity(0.2)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [
                            Color.red.opacity(0.8),
                            Color.purple.opacity(0.6),
                            Color.blue.opacity(0.8)
                        ]), startPoint: .leading, endPoint: .trailing), lineWidth: 4
                    )
                    .blur(radius: 2)
            )
            .shadow(color: Color.red.opacity(0.6), radius: 8, x: 0, y: 4)
    }
}

extension View {
    func sith() -> some View {
        self.modifier(SithModifier())
    }
}
