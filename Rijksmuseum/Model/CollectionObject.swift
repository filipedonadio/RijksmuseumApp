//
//  CollectionObject.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct CollectionObject: Decodable, Identifiable, Hashable {
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(objectNumber)
        hasher.combine(title)
    }
    
    static func == (lhs: CollectionObject, rhs: CollectionObject) -> Bool {
        lhs.objectNumber == rhs.objectNumber && lhs.title == rhs.title
    }
}

extension CollectionObject {
    static let testData = CollectionObject(
        objectNumber: "en-SK-A-1718",
        title: "Winter Landscape with Ice Skaters",
        principalOrFirstMaker: "Hendrick Avercamp",
        webImage: WebImage.testData,
        isFavorite: false
    )
}
