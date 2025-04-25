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
    @Published var bubbles: [BubbleModel.Bubble] = []
    
    private var timer: Timer? = nil
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func startGame() {
        isGameStarted = true
    }
    
    // Storing and Managing Bubbles Functions
    func generateBubbles(in size: CGSize) {
        var newBubbles: [BubbleModel.Bubble] = []
        
        let max = gameModel.maxBubbles
        let actualCount = Int.random(in: 1...max) // randomly pick num from 1 to maxbubbles
        print("Bubble Random Num:", actualCount)
        let radius: CGFloat = 40 // circle radius
        let margin: CGFloat = 20  // padding so bubbles dont go out of bounds

        var attempts = 0
        let maxAttempts = 1000
        while newBubbles.count < actualCount && attempts < maxAttempts {
            let color = generateRandomColor()

            // generate random pos
            let x = CGFloat.random(in: (radius + margin)...(size.width - radius - margin))
            let y = CGFloat.random(in: (radius + margin)...(size.height - radius - margin))
            let position = CGPoint(x: x, y: y)
            
            // check if bubble oerlaps with any existing bubble
            let newBubble = BubbleModel.Bubble(color: color, position: position)

            if newBubbles.allSatisfy({ distance($0.position, position) > (radius * 2) + 5 }) {
                newBubbles.append(newBubble)
            }
            
            attempts += 1
        }
        
        // error handling: set max attempts at 1000 as a fallback to avoid infinite loop in he case that bubble cant be placed
        if newBubbles.count < actualCount {
            print("Could only place \(newBubbles.count) out of \(actualCount) bubbles.")
        }

        self.bubbles = newBubbles
    }

    private func generateRandomColor() -> BubbleModel.BubbleColour {
        let roll = Double.random(in: 0...1)
        var total: Double = 0
        for color in BubbleModel.BubbleColour.allCases {
            total += color.appearanceChance
            if roll <= total {
                return color
            }
        }
        return .red // fallback
    }

    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        return hypot(a.x - b.x, a.y - b.y)
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
