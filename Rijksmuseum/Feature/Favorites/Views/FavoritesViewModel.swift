//
//  FavoritesViewModel.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 15/05/2023.
//

import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var collectionObjects: [CollectionObject] = []
    
    let favoriteDataService: FavoriteDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(favoriteDataService: FavoriteDataService) {
        self.favoriteDataService = favoriteDataService
        
        favoriteDataService.$savedEntities.sink { [weak self] favoriteEntities in
            let artObjects = favoriteEntities.compactMap { favoriteEntity -> CollectionObject? in
                guard let objectNumber = favoriteEntity.objectNumber,
                      let title = favoriteEntity.title,
                      let subtitle = favoriteEntity.subtitle,
                      let imageUrl = favoriteEntity.imageUrl
                else {
                    return nil
                }
                return CollectionObject(
                    objectNumber: objectNumber,
                    title: title,
                    principalOrFirstMaker: subtitle,
                    webImage: WebImage(url: imageUrl)
                )
            }
            
            self?.collectionObjects = artObjects
        }
        .store(in: &cancellables)
    }
}
