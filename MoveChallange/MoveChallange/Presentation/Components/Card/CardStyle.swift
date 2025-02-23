//
//  CardStyle.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

protocol CardStyle {
    associatedtype Body: View
    typealias Configuration = CardStyleConfiguration

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

struct AnyCardStyle: CardStyle {
    private var _makeBody: (Configuration) -> AnyView

    init<S: CardStyle>(style: S) {
        _makeBody = {
            AnyView(style.makeBody(configuration: $0))
        }
    }

    func makeBody(configuration: Configuration) -> AnyView {
        _makeBody(configuration)
    }
}

struct FilmCardStyle: CardStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Text(configuration.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            if let subtitle = configuration.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .atmosphere()
    }
}

struct CharacterCardStyle: CardStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Text(configuration.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.top, 10)
            if let subtitle = configuration.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .multilineTextAlignment(.center)
            }
        }
        .sith()
    }
}

struct SpaceshipCardStyle: CardStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Text(configuration.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            if let subtitle = configuration.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .spaceship()
    }
}
