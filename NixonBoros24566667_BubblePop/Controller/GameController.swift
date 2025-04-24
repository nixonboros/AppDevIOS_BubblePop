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

        var attempts = 0
        while newBubbles.count < max && attempts < max * 10 {
            let color = generateRandomColor()
            let radius: CGFloat = 40
            let x = CGFloat.random(in: radius...(size.width - radius))
            let y = CGFloat.random(in: radius...(size.height - radius))
            let position = CGPoint(x: x, y: y)

            let newBubble = BubbleModel.Bubble(color: color, position: position)

            if newBubbles.allSatisfy({ distance($0.position, position) > radius * 2 }) {
                newBubbles.append(newBubble)
            }
            attempts += 1
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
