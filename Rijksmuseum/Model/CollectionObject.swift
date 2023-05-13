//
//  CollectionObject.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct CollectionObject: Decodable {
    let objectNumber: String
    let title: String
    let principalOrFirstMaker: String
    let webImage: WebImage
}
