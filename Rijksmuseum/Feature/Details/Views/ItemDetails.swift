//
//  ItemDetails.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ItemDetails: View {
    let objectNumber: String
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.footnote)
                        .foregroundColor(.theme.secondaryTextColor)
                    Text("Lorem ipsum dolor sit amet.")
                        .font(.body)
                        .foregroundColor(.theme.primaryTextColor)
                }
            } header: {
                Text("Identification")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.theme.primaryTextColor)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Object number: \(objectNumber)")
    }
}

struct ItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetails(objectNumber: "SK-A-1718")
    }
}
