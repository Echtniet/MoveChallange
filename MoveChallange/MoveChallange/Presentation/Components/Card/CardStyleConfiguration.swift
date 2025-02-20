//
//  CardStyleConfiguration.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct CardStyleConfiguration {
    let title: String
    let subtitle: String?

    let onTap: () -> Void
}

struct CardStyleKey: EnvironmentKey {
    static let defaultValue = AnyCardStyle(style: CharacterCardStyle())
}


extension EnvironmentValues {
      var cardStyle: AnyCardStyle {
            get { self[CardStyleKey.self] }
            set { self[CardStyleKey.self] = newValue }
      }
}

extension View {
    func cardStyle(_ style: CardStyles = .character) -> some View {
        switch style {
        case .character:
            environment(\.cardStyle, AnyCardStyle(style: CharacterCardStyle()))
        case .film:
            environment(\.cardStyle, AnyCardStyle(style: FilmCardStyle()))
        case .spaceship:
            environment(\.cardStyle, AnyCardStyle(style: SpaceshipCardStyle()))
        }
    }
}

enum CardStyles {
    case character
    case film
    case spaceship
}
