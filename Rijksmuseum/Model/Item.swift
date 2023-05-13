//
//  Item.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct Item: Decodable {
    let acquisition: Acquisition
    let copyrightHolder: String?
    let dating: Dating
    let label: Label
    let materials: [String]
    let objectNumber: String?
    let objectTypes: [String]
    let principalOrFirstMaker: String?
    let productionPlaces: [String]
    let subTitle: String?
    let techniques: [String]
    let title: String?
    let webImage: WebImage?
}
