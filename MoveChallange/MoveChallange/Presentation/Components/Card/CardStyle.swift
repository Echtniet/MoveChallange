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
//        .onTapGesture {
//            configuration.onTap()
//        }
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
//        .onTapGesture {
//            configuration.onTap()
//        }
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
//        .onTapGesture {
//            configuration.onTap()
//        }
    }
}
