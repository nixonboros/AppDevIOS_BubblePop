//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    let playerName: String
    
    var body: some View {
        Text(playerName)
    }
}

#Preview {
    GameView(playerName: "EmptyPlayerName")
}
