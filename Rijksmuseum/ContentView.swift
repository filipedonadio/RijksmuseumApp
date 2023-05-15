//
//  ContentView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var favoriteDataService: FavoriteDataService
    
    var body: some View {
        TabView {
            ArtCollectionView(viewModel: ArtCollectionViewModel(
                favoriteDataService: favoriteDataService)
            )
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("Collection")
            }
            FavoritesView(viewModel: FavoritesViewModel(
                favoriteDataService: favoriteDataService)
            )
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
            .badge(favoriteDataService.savedEntities.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
