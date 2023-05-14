//
//  ItemTile.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import SwiftUI
import Kingfisher

struct ItemTile: View {
    let imageUrl: URL?
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Color.clear
                    .frame(height: 250)
                
                KFImage(imageUrl)
                    .resizable()
                    .downsampling(size: CGSize(width: 400, height: 250))
                    .scaledToFill()
                    .layoutPriority(-1)
            }
            .clipped()
            
            VStack(alignment: .leading) {
                Group {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.theme.primaryTextColor)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.theme.secondaryTextColor)
                }
                .lineLimit(1)
            }
            .padding(8)
        }
        .background(Color.theme.backgroundElevatedColor)
        .cornerRadius(8)
    }
}

struct ItemTile_Previews: PreviewProvider {
    static var previews: some View {
        ItemTile(
            imageUrl: URL(string: "https://lh3.googleusercontent.com/1pTfYJlLwVTifKj4PlsWPyAg4PcIVBAiVvB8sameSnmm7HRd056abNUIRq33rgry7u9t-ju-eHOnbfqQpK4q_8IwzIXZ4WgrqZW9l7U=s0")!,
            title: "Winter Landscape with Ice Skaters",
            subtitle: "Hendrick Avercamp"
        )
    }
}
