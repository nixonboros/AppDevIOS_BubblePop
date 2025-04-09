//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    let playerName: String
    let gameTime: Int
    let maxBubbles: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            VStack {
                Text(playerName)
                Text("\(gameTime)")
                Text("\(maxBubbles)")
            }
        }
    }
}
