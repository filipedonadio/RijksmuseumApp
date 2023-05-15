//
//  CollectionGrid.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 15/05/2023.
//

import SwiftUI

struct CollectionGrid<Content: View>: View {
    @ViewBuilder var content: Content
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            content
        }
        .padding(8)
    }
}

struct CollectionGrid_Previews: PreviewProvider {
    static var previews: some View {
        CollectionGrid {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
            Text("Item 4")
        }
    }
}
