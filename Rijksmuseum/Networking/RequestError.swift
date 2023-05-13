//
//  RequestError.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return  "An error has occurred while decoding the data."
        case .unauthorized:
            return "The request has not been completed because it lacks valid authentication credentials."
        default:
            return "Something went wrong."
        }
    }
}
