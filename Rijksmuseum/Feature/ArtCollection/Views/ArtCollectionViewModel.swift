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
    @Published var collectionFromAPI: [CollectionObject] = []
    
    let favoriteDataService: FavoriteDataService
    private let collectionService = CollectionServiceImpl()
    private var cancellables = Set<AnyCancellable>()
    
    init(favoriteDataService: FavoriteDataService) {
        self.favoriteDataService = favoriteDataService
        Task {
            await fetchCollection(type: .painting)
        }
        
        addSubscribers()
    }
    
    func fetchCollection(type: CollectionObjectType) async {
        state = .loading
        
        do {
            let collection = try await collectionService.fetch(type: type)
            collectionFromAPI = collection.artObjects
        } catch {
            state = .error
        }
    }
    
    private func addSubscribers() {
        $collectionFromAPI
            .combineLatest(favoriteDataService.$savedEntities)
            .map { (collectionObjects, favoriteEntities) -> [CollectionObject] in
                collectionObjects.map { collectionObject in
                    if favoriteEntities.first(where: { $0.objectNumber == collectionObject.objectNumber }) != nil {
                        return collectionObject.updateFavorite()
                    }
                    return collectionObject
                }
            }
            .sink { [weak self] returnedObjects in
                self?.state = .success(elements: Collection(artObjects: returnedObjects))
            }
            .store(in: &cancellables)
    }
}
