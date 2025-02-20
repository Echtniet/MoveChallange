//
//  Card.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct Card: View {
    @Environment(\.cardStyle) var style

    let title: String
    let subtitle: String?

    let onTap: () -> Void

    var body: some View {
        style
            .makeBody(configuration: CardStyleConfiguration(
                title: title,
                subtitle: subtitle,
                onTap: onTap
            ))
    }
}
