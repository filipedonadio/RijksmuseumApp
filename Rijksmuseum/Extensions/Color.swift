//
//  Color.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let backgroundElevatedColor = Color("BackgroundElevatedColor")
    let primaryTextColor = Color("PrimaryTextColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}
