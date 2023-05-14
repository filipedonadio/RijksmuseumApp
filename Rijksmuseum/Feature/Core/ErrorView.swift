//
//  ErrorView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct ErrorView: View {
    let tryAgainAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.circle")
                .font(.system(size: 80))
                .fontWeight(.light)
                .foregroundColor(.theme.primaryTextColor)
                .padding(.bottom, 32)
            Text("Oh no!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            Text("Something went wrong. Please try again.")
                .foregroundColor(.theme.secondaryTextColor)
                .font(.body)
            Spacer()
            Button("Try again") {
                tryAgainAction()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 40)
            .background(Color.theme.accent)
            .cornerRadius(8)
            .foregroundColor(.white)
            .font(.body)
            .fontWeight(.bold)
            .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundElevatedColor)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(tryAgainAction: {})
    }
}
