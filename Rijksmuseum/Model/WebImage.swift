//
//  WebImage.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

struct WebImage: Decodable {
    let guid: String
    let url: String
}

extension WebImage {
    static let testData = WebImage(
        guid: "4f834f63-3aeb-48a2-8a22-bcac12ffc3b9",
        url: "https://lh3.googleusercontent.com/1pTfYJlLwVTifKj4PlsWPyAg4PcIVBAiVvB8sameSnmm7HRd056abNUIRq33rgry7u9t-ju-eHOnbfqQpK4q_8IwzIXZ4WgrqZW9l7U=s0"
    )
}
