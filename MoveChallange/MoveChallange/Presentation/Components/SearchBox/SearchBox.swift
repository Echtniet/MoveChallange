//
//  SearchBox.swift
//  MoveChallange
//
//  Created by Clinton on 20/02/2025.
//

import SwiftUI

struct SearchBoxView: View {

    @State private var isExpanded: Bool = false
    @Binding var text: String
    var animation: Namespace.ID
    var color: Color
    // not clean but oh well for now
    var searchBoxStyle: CardStyles = .character

    var body: some View {
        HStack {
            if !isExpanded {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundStyle(color)
                    .matchedGeometryEffect(id: "searchBox_\(color)", in: animation)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            } else {
                switch searchBoxStyle {
                case .character:
                    TextField("Search...", text: $text)
                        .padding(8)
                        .sith()
                        .matchedGeometryEffect(id: "searchBox_\(color)", in: animation)
                case .film:
                    TextField("Search...", text: $text)
                        .padding(8)
                        .atmosphere()
                        .matchedGeometryEffect(id: "searchBox_\(color)", in: animation)
                case .spaceship:
                    TextField("Search...", text: $text)
                        .padding(8)
                        .spaceship()
                        .matchedGeometryEffect(id: "searchBox_\(color)", in: animation)
                }

            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

}
