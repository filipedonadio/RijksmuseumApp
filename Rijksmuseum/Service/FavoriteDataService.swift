//
//  FavoriteDataService.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import CoreData

class FavoriteDataService: ObservableObject {
    private let container: NSPersistentContainer
    private let containerName = "FavoriteContainer"
    private let entityName = "FavoriteEntity"
    
    @Published var savedEntities: [FavoriteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error {
                assertionFailure(error.localizedDescription)
            }
            self.getFavorites()
        }
    }
    
    // MARK: - Public
    
    func updateFavorite(objectNumber: String) {
        // Check if the item is already a favorite.
        if let entity = savedEntities.first(where: { $0.objectNumber == objectNumber }) {
            delete(entity: entity)
        } else {
            add(objectNumber: objectNumber)
        }
    }
    
    // MARK: - Private
    
    private func getFavorites() {
        let request = NSFetchRequest<FavoriteEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    private func add(objectNumber: String) {
        let entity = FavoriteEntity(context: container.viewContext)
        entity.objectNumber = objectNumber
        applyChanges()
    }
    
    private func update(entity: FavoriteEntity, objectNumber: String) {
        entity.objectNumber = objectNumber
        applyChanges()
    }
    
    private func delete(entity: FavoriteEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    private func applyChanges() {
        save()
        getFavorites()
    }
}
