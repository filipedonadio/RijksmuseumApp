//
//  RijksmuseumApp.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import SwiftUI

@main
struct RijksmuseumApp: App {
    @StateObject private var favoriteDataService = FavoriteDataService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteDataService)
        }
    }
}
