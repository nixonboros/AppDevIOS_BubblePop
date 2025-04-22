//
//  GameController.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

class GameController: ObservableObject {
    @Published var isGameStarted: Bool = false
    @Published var gameModel: GameModel
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func startGame() {
        isGameStarted = true
    }
    
    // Game Settings Update Functions
    func updatePlayerName(newName: String) {
        gameModel.playerName = newName
    }
    
    func updateGameTime(gameTime: Int) {
        gameModel.gameTime = gameTime
    }
    
    func updateMaxBubbles(maxBubbles: Int) {
        gameModel.maxBubbles = maxBubbles
    }
}
