//
//  GameModel.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 9/4/2025.
//

import SwiftUI

class GameModel: ObservableObject {
    var playerName: String
        var gameTime: Int
        var maxBubbles: Int

        init(playerName: String = "", gameTime: Int = 60, maxBubbles: Int = 15) {
            self.playerName = playerName
            self.gameTime = gameTime
            self.maxBubbles = maxBubbles
        }
}
