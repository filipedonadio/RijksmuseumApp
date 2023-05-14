//
//  ItemDetailsViewModel.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import Combine

@MainActor
final class ItemDetailsViewModel: ObservableObject {
    @Published var state: ViewState<Item> = .empty
    @Published var isFavorite = false
    
    let collectionObject: CollectionObject
    private let collectionService = CollectionServiceImpl()
    private let favoriteDataService: FavoriteDataService
    private var cancellables = Set<AnyCancellable>()
    
    var formattedObjectNumber: String {
        "Object number: \(collectionObject.objectNumber)"
    }
    
    init(collectionObject: CollectionObject, favoriteDataService: FavoriteDataService) {
        self.collectionObject = collectionObject
        self.favoriteDataService = favoriteDataService
        
        Task {
            await fetchDetails()
        }
        
        addSubscribers()
    }
    
    func fetchDetails() async {
        state = .loading
        
        do {
            let itemDetails = try await collectionService.fetchDetails(for: collectionObject.objectNumber)
            state = .success(elements: itemDetails.artObject)
        } catch {
            state = .error
        }
    }
    
    func formatMultipleInformation(_ items: [String]) -> String {
        items.map{ String($0.capitalized) }.joined(separator: ", ")
    }
    
    func updateFavorite() {
        favoriteDataService.updateFavorite(for: collectionObject)
    }
    
    private func addSubscribers() {
        favoriteDataService.$savedEntities.sink { [weak self] favorites in
            let favoriteEntity = favorites.first(where: { $0.objectNumber == self?.collectionObject.objectNumber })
            if favoriteEntity != nil {
                self?.isFavorite = true
            } else {
                self?.isFavorite = false
            }
        }
        .store(in: &cancellables)
    }
}
