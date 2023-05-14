//
//  LogoView.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 154, height: 20)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
