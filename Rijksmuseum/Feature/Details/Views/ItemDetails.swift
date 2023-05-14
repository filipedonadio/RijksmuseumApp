//
//  ItemDetails.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ItemDetails: View {
    @StateObject var viewModel: ItemDetailsViewModel
    
    var body: some View {
        VStack {
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
                    } header: {
                        Text("Identification")
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
    }
}

struct ItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetails(viewModel: ItemDetailsViewModel(objectNumber: "SK-A-1718"))
    }
}
