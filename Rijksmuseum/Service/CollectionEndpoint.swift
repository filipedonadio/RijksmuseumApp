//
//  CollectionEndpoint.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

enum CollectionEndpoint {
    case collection
    case details(objectNumber: String)
}

extension CollectionEndpoint: Endpoint {
    private var apiKey: String {
        "?key=ET5iIuL8"
    }
    
    var path: String {
        switch self {
        case .collection: return "collection".appending(apiKey)
        case .details(let objectNumber): return "collection/\(objectNumber)".appending(apiKey)
        }
    }
}
