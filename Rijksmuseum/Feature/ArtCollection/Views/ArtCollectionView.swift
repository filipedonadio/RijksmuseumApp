//
//  ArtCollectionView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ArtCollectionView: View {
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                MenuBar()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        // TODO: Display ItemTile
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoView()
                }
            }
        }
    }
}

struct ArtCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ArtCollectionView()
    }
}
