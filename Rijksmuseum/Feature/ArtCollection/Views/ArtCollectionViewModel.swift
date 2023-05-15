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
    @Published var isLoadingPage = false
    @Published private var collectionFromAPI: [CollectionObject] = []
    
    let favoriteDataService: FavoriteDataService
    var currentPage = 1
    private var canLoadMorePages = true
    private var collectionObjects: [CollectionObject] = []
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
            let collection = try await collectionService.fetch(type: type, page: currentPage)
            collectionFromAPI = collection.artObjects
        } catch {
            state = .error
        }
    }
    
    func loadMoreItemsIfNeeded(currentObject: CollectionObject, selectedType: CollectionObjectType) async {
        let thresholdIndex = collectionObjects.index(collectionObjects.endIndex, offsetBy: -2)
        if collectionObjects.firstIndex(where: { $0.objectNumber == currentObject.objectNumber }) == thresholdIndex {
            await loadMoreContent(selectedType: selectedType)
        }
    }
    
    private func loadMoreContent(selectedType: CollectionObjectType) async {
        guard !isLoadingPage && canLoadMorePages else { return }

        isLoadingPage = true
        currentPage += 1
        
        do {
            let collection = try await collectionService.fetch(type: selectedType, page: currentPage)
            collectionFromAPI.append(contentsOf: collection.artObjects)
            canLoadMorePages = !collection.artObjects.isEmpty
            isLoadingPage = false
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
                self?.collectionObjects = returnedObjects
                self?.state = .success(elements: Collection(artObjects: returnedObjects))
            }
            .store(in: &cancellables)
    }
}
