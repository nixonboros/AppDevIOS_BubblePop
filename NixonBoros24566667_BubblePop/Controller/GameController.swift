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
    private var previousBubbleColor: BubbleModel.BubbleColour? = nil
    private var scoreMultiplier: Double = 1.0
    
    @Published var score: Int = 0
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func startGame() {
        isGameStarted = true
    }
    
    // generate bubbles
    func generateBubbles(in size: CGSize) {
        var newBubbles: [BubbleModel.Bubble] = []
        
        let max = gameModel.maxBubbles
        let actualCount = Int.random(in: 1...max) // randomly pick num from 1 to maxbubbles
        print("Bubbles Generated:", actualCount)
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

    // generate random bubble colour
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

    // calc distance
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        return hypot(a.x - b.x, a.y - b.y)
    }
    
    // pop bubble
    func popBubble(bubble: BubbleModel.Bubble) {
        let baseScore = bubble.color.pointValue
        let finalScore: Int
        
        if let previousColor = previousBubbleColor, previousColor == bubble.color {
            // Apply multiplier for consecutive bubbles
            finalScore = Int((Double(baseScore) * 1.5).rounded())
        } else {
            finalScore = baseScore
        }

        // Update score
        print("Score:", "+\(finalScore)")
        score += finalScore
        previousBubbleColor = bubble.color

        // Remove the bubble
        bubbles.removeAll { $0.id == bubble.id }
    }
    
    func refreshBubbles(in size: CGSize) {
        let currentCount = bubbles.count
        let max = gameModel.maxBubbles

        // Decide how many to remove (random number)
        let removeCount = Int.random(in: 0...min(currentCount, max / 2))
        var newBubbles = bubbles

        if removeCount > 0 {
            newBubbles.shuffle()
            newBubbles.removeLast(removeCount)
        }

        // Calculate how many new bubbles to add (without exceeding max)
        let availableSlots = max - newBubbles.count
        let newCount = Int.random(in: 0...availableSlots)
        print("Bubbles Removed & Generated:", removeCount, "|", newCount)

        let radius: CGFloat = 40
        let margin: CGFloat = 20
        var addedCount = 0
        var attempts = 0

        while addedCount < newCount && attempts < 500 {
            let color = generateRandomColor()
            let x = CGFloat.random(in: (radius + margin)...(size.width - radius - margin))
            let y = CGFloat.random(in: (radius + margin)...(size.height - radius - margin))
            let position = CGPoint(x: x, y: y)
            let newBubble = BubbleModel.Bubble(color: color, position: position)

            if newBubbles.allSatisfy({ distance($0.position, position) > (radius * 2) + 5 }) {
                newBubbles.append(newBubble)
                addedCount += 1
            }

            attempts += 1
        }

        self.bubbles = newBubbles
    }

    
    // game Settings Update Functions
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
