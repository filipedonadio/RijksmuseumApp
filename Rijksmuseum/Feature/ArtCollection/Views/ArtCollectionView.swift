//
//  ArtCollectionView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ArtCollectionView: View {
    var body: some View {
        NavigationStack {
            Text("ArtCollectionView")
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
