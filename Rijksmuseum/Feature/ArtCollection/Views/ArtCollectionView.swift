//
//  ArtCollectionView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ArtCollectionView: View {
    @StateObject var viewModel = ArtCollectionViewModel()
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .error:
                    ErrorView(tryAgainAction: {
                        Task {
                            await viewModel.fetchCollection()
                        }
                    })
                case .loading:
                    makeCollectionStack(with: LoadingView())
                case .success(let collection):
                    makeCollectionStack(with: makeScrollView(collection: collection))
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
    
    private func makeCollectionStack(with content: some View) -> some View {
        VStack {
            MenuBar()
            content
        }
    }
    
    private func makeScrollView(collection: Collection) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(collection.artObjects) { item in
                    NavigationLink(value: item.objectNumber) {
                        ItemTile(
                            imageUrl: URL(string: item.webImage.url),
                            title: item.title,
                            subtitle: item.principalOrFirstMaker
                        )
                    }
                }
            }
            .navigationDestination(for: String.self) { objectNumber in
                ItemDetails(viewModel: ItemDetailsViewModel(objectNumber: objectNumber))
            }
            .padding(8)
        }
    }
}

struct ArtCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ArtCollectionView()
    }
}
