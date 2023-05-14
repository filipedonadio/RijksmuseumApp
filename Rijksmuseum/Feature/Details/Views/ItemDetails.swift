//
//  ItemDetails.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI
import Kingfisher

struct ItemDetails: View {
    @StateObject var viewModel: ItemDetailsViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            switch viewModel.state {
            case .error:
                ErrorView(tryAgainAction: {
                    Task {
                        await viewModel.fetchDetails()
                    }
                })
            case .loading:
                LoadingView()
            case .success(let itemDetails):
                List {
                    if let url = itemDetails.webImage?.url {
                        KFImage(URL(string: url))
                            .downsampling(size: CGSize(width: 960, height: 540))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .listRowSeparator(.hidden)
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            if let title = itemDetails.title {
                                Text("Title")
                                    .font(.footnote)
                                    .foregroundColor(.theme.secondaryTextColor)
                                Text(title)
                                    .font(.body)
                                    .foregroundColor(.theme.primaryTextColor)
                            }
                        }
                        
                        if let description = itemDetails.label.description {
                            Text("Description")
                                .font(.footnote)
                                .foregroundColor(.theme.secondaryTextColor)
                            Text(description)
                                .font(.body)
                                .foregroundColor(.theme.primaryTextColor)
                        }
                        
                        if !itemDetails.objectTypes.isEmpty {
                            Text("Object type")
                                .font(.footnote)
                                .foregroundColor(.theme.secondaryTextColor)
                            Text(viewModel.formatMultipleInformation(itemDetails.objectTypes))
                                .font(.body)
                                .foregroundColor(.theme.primaryTextColor)
                        }
                    } header: {
                        Text("Identification")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.primaryTextColor)
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            if let maker = itemDetails.principalOrFirstMaker {
                                Text("Artist")
                                    .font(.footnote)
                                    .foregroundColor(.theme.secondaryTextColor)
                                Text(maker)
                                    .font(.body)
                                    .foregroundColor(.theme.primaryTextColor)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            if let presentingDate = itemDetails.dating.presentingDate {
                                Text("Dating")
                                    .font(.footnote)
                                    .foregroundColor(.theme.secondaryTextColor)
                                Text(presentingDate)
                                    .font(.body)
                                    .foregroundColor(.theme.primaryTextColor)
                            }
                        }
                    } header: {
                        Text("Creation")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.primaryTextColor)
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            if !itemDetails.materials.isEmpty {
                                Text("Material")
                                    .font(.footnote)
                                    .foregroundColor(.theme.secondaryTextColor)
                                Text(viewModel.formatMultipleInformation(itemDetails.materials))
                                    .font(.body)
                                    .foregroundColor(.theme.primaryTextColor)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            if let subTitle = itemDetails.subTitle {
                                Text("Measurements")
                                    .font(.footnote)
                                    .foregroundColor(.theme.secondaryTextColor)
                                Text(subTitle)
                                    .font(.body)
                                    .foregroundColor(.theme.primaryTextColor)
                            }
                        }
                    } header: {
                        Text("Material and Technique")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.theme.primaryTextColor)
                    }
                }
            case .empty:
                Color.clear
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.formattedObjectNumber)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewModel.updateFavorite()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(Color.theme.accent)
                }

            }
        }
    }
}

struct ItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetails(
            viewModel: ItemDetailsViewModel(
                collectionObject: CollectionObject.testData,
                favoriteDataService: FavoriteDataService()
            )
        )
    }
}
