//
//  ItemDetailsViewModel.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import Foundation

@MainActor
final class ItemDetailsViewModel: ObservableObject {
    @Published var state: ViewState<Item> = .empty
    let objectNumber: String
    private let collectionService = CollectionServiceImpl()
    
    var formattedObjectNumber: String {
        "Object number: \(objectNumber)"
    }
    
    init(objectNumber: String) {
        self.objectNumber = objectNumber
        
        Task {
            await fetchDetails()
        }
    }
    
    func fetchDetails() async {
        state = .loading
        
        do {
            let itemDetails = try await collectionService.fetchDetails(for: objectNumber)
            state = .success(elements: itemDetails.artObject)
        } catch {
            state = .error
        }
    }
    
}
