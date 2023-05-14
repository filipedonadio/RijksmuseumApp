//
//  ArtCollectionView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ArtCollectionView: View {
    @StateObject var viewModel: ArtCollectionViewModel
    @State private var selectedType: CollectionObjectType = .painting
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var menuBar: some View {
        MenuBar(selectedType: $selectedType)
            .onChange(of: selectedType) { tappedType in
                Task {
                    await viewModel.fetchCollection(type: tappedType)
                }
            }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                menuBar
                switch viewModel.state {
                case .error:
                    ErrorView(tryAgainAction: {
                        Task {
                            await viewModel.fetchCollection(type: selectedType)
                        }
                    })
                case .loading:
                    LoadingView()
                case .success(let collection):
                    makeScrollView(with: collection)
                case .empty:
                    Color.clear
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
    
    private func makeScrollView(with collection: Collection) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(collection.artObjects) { item in
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
            .navigationDestination(for: CollectionObject.self) { collectionObject in
                ItemDetails(viewModel: ItemDetailsViewModel(collectionObject: collectionObject, favoriteDataService: viewModel.favoriteDataService))
            }
            .padding(8)
        }
    }
}

struct ArtCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ArtCollectionView(viewModel: ArtCollectionViewModel(favoriteDataService: FavoriteDataService()))
    }
}
