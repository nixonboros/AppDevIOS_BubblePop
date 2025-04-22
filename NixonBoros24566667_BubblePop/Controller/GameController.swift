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
    
    private var timer: Timer? = nil
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func startGame() {
        isGameStarted = true
    }
    
    func startGameTimer(from seconds: Int) {
        gameModel.gameTime = seconds
        stopGameTimer() // in case timer is alr running

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.gameModel.gameTime > 0 {
                self.gameModel.gameTime -= 1
            } else {
                self.stopGameTimer()
                // Placeholder: Do something when the timer hits 0
            }
        }
    }
    
    func stopGameTimer() {
            timer?.invalidate()
            timer = nil
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
