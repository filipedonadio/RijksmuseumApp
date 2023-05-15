//
//  WebImage.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct WebImage: Decodable {
    let url: String
}

extension WebImage {
    static let testData = WebImage(
        url: "https://lh3.googleusercontent.com/1pTfYJlLwVTifKj4PlsWPyAg4PcIVBAiVvB8sameSnmm7HRd056abNUIRq33rgry7u9t-ju-eHOnbfqQpK4q_8IwzIXZ4WgrqZW9l7U=s0"
    )
}
