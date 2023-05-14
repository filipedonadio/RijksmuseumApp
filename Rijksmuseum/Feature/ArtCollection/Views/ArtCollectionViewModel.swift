//
//  ArtCollectionViewModel.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import Foundation

@MainActor
final class ArtCollectionViewModel: ObservableObject {
    @Published var state: ViewState<Collection> = .empty
    
    private let collectionService = CollectionServiceImpl()
    
    init() {
        Task {
            await fetchCollection()
        }
    }
    
    func fetchCollection() async {
        state = .loading
        
        do {
            let collection = try await collectionService.fetch(type: .painting)
            state = .success(elements: collection)
        } catch {
            state = .error
        }
    }
}
