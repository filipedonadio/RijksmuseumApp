//
//  ArtCollectionViewModel.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import Combine

@MainActor
final class ArtCollectionViewModel: ObservableObject {
    @Published var state: ViewState<Collection> = .empty
    
    let favoriteDataService: FavoriteDataService
    private let collectionService = CollectionServiceImpl()
    private var cancellables = Set<AnyCancellable>()
    
    init(favoriteDataService: FavoriteDataService) {
        self.favoriteDataService = favoriteDataService
        Task {
            await fetchCollection()
        }
    }
    
    func fetchCollection() async {
        state = .loading
        
        do {
            let collection = try await collectionService.fetch(type: .painting)
            
            favoriteDataService.$savedEntities.sink { [weak self] savedFavorites in
                let elements = collection.artObjects.map { collectionObject in
                    if savedFavorites.contains(where: { $0.objectNumber == collectionObject.objectNumber }) {
                        return collectionObject.updateFavorite()
                    }
                    return collectionObject
                }
                self?.state = .success(elements: Collection(artObjects: elements))
            }
            .store(in: &cancellables)
        } catch {
            state = .error
        }
    }
}
