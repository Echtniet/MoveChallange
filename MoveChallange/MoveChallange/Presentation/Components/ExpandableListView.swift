//
//  ExpandableListView.swift
//  MoveChallange
//
//  Created by Clinton on 22/02/2025.
//

import SwiftUI

struct ExpandableListView<Item: Hashable, Content: View>: View {
    let title: String
    let items: [Item]
    @State private var isExpanded: Bool = false
    let content: (Item) -> Content

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
            }
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.8)) {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                Divider()
                ForEach(items, id: \ .self) { item in
                    content(item)
                }
            }
        }
    }
}
