//
//  CollectionObject.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct CollectionObject: Decodable, Identifiable {
    let objectNumber: String
    let title: String
    let principalOrFirstMaker: String
    let webImage: WebImage
    var isFavorite: Bool = false
    
    var id: String {
        objectNumber
    }
    
    private enum CodingKeys: String, CodingKey {
        case objectNumber, title, principalOrFirstMaker, webImage
    }
    
    func updateFavorite() -> CollectionObject {
        CollectionObject(
            objectNumber: objectNumber,
            title: title,
            principalOrFirstMaker: principalOrFirstMaker,
            webImage: webImage,
            isFavorite: !isFavorite
        )
    }
}
