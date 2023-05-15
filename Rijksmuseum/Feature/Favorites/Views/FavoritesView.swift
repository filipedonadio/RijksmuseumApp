//
//  FavoritesView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.collectionObjects.isEmpty {
                    VStack(spacing: 24.0) {
                        Spacer()
                        Text("There are no items.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.primaryTextColor)
                        Text("Browse the art collection and favorite some items ❤️")
                            .font(.body)
                            .foregroundColor(.theme.secondaryTextColor)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(16)
                } else {
                    ScrollView {
                        CollectionGrid {
                            ForEach(viewModel.collectionObjects) { item in
                                NavigationLink(value: item) {
                                    ItemTile(
                                        imageUrl: URL(string: item.webImage.url),
                                        title: item.title,
                                        subtitle: item.principalOrFirstMaker,
                                        isFavorite: item.isFavorite
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: CollectionObject.self) { collectionObject in
                ItemDetails(viewModel: ItemDetailsViewModel(collectionObject: collectionObject, favoriteDataService: viewModel.favoriteDataService))
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavoritesViewModel(favoriteDataService: FavoriteDataService()))
    }
}
