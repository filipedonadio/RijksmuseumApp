//
//  Endpoint.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://www.rijksmuseum.nl/api/en/"
    }
}
