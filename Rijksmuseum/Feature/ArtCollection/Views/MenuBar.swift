//
//  MenuBar.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let collectionType: CollectionObjectType
}

struct MenuBar: View {
    @State private var selectedType: CollectionObjectType = .painting
    
    private let menuItems = [
        MenuItem(collectionType: .painting),
        MenuItem(collectionType: .box),
        MenuItem(collectionType: .brooch),
        MenuItem(collectionType: .candlestick),
        MenuItem(collectionType: .cup),
        MenuItem(collectionType: .demonstrationModel),
        MenuItem(collectionType: .figure),
        MenuItem(collectionType: .fragment),
        MenuItem(collectionType: .furniture),
        MenuItem(collectionType: .jeton),
        MenuItem(collectionType: .jewellery)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16.0) {
                ForEach(menuItems) { item in
                    Text(item.collectionType.rawValue.capitalized)
                        .font(.headline)
                        .foregroundColor(isSelectedType(item.collectionType) ? .theme.accent : .theme.secondaryTextColor)
                        .fontWeight(isSelectedType(item.collectionType) ? .bold : .regular)
                        .underline(isSelectedType(item.collectionType) ? true : false)
                        .onTapGesture {
                            selectedType = item.collectionType
                        }
                }
            }
        }
    }
    
    private func isSelectedType(_ type: CollectionObjectType) -> Bool {
        type == selectedType
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
    }
}
