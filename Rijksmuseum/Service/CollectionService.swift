//
//  CollectionService.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

protocol CollectionService {
    /// Fetch the art collection.
    /// - Parameters:
    ///   - type: `CollectionObjectType` describing the type of art.
    ///   - page: Int describing which page to fetch.
    /// - Returns: Collection representing a group of art items.
    func fetch(type: CollectionObjectType, page: Int) async throws -> Collection
    
    
    /// Fetch the details of an art object.
    /// - Parameter objectNumber: String describing the object identification.
    /// - Returns: `ArtObject` representing the informating about an art object.
    func fetchDetails(for objectNumber: String) async throws -> ArtObject
}

final class CollectionServiceImpl: HTTPClient, CollectionService {
    func fetch(type: CollectionObjectType, page: Int = 0) async throws -> Collection {
        var params = [URLQueryItem]()
        
        params.append(URLQueryItem(name: "p", value: String(page)))
        
        let typeQueryItem = URLQueryItem(name: "type", value: type.rawValue)
        params.append(typeQueryItem)
        
        let imageOnlyQueryItem = URLQueryItem(name: "imgonly", value: "True")
        params.append(imageOnlyQueryItem)
        
        let resultsPerPage = URLQueryItem(name: "ps", value: "20")
        params.append(resultsPerPage)
        
        return try await sendRequest(endpoint: CollectionEndpoint.collection, parameters: params, responseModel: Collection.self)
    }
    
    func fetchDetails(for objectNumber: String) async throws -> ArtObject {
        try await sendRequest(endpoint: CollectionEndpoint.details(objectNumber: objectNumber), responseModel: ArtObject.self)
    }
}
