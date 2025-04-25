//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var gameController: GameController

    let playerName: String
    let maxBubbles: Int

    @State private var timeLeft: Int
    @State private var timer: Timer? = nil
    @State private var isGameOver: Bool = false
    
    @State private var fadeIn: Bool = false
    @State private var fadeOut: Bool = false
    
    init(playerName: String, gameTime: Int, maxBubbles: Int) {
        self.playerName = playerName
        self.maxBubbles = maxBubbles
        _timeLeft = State(initialValue: gameTime)

        let gameModel = GameModel(playerName: playerName, gameTime: gameTime, maxBubbles: maxBubbles)
        _gameController = StateObject(wrappedValue: GameController(gameModel: gameModel))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGroupedBackground))
                    .ignoresSafeArea()
                
                if isGameOver {
                    GameOverView(playerName: playerName, finalScore: gameController.score)
                        // fade into next scene
                        .opacity(fadeIn ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                fadeIn = true
                            }
                        }
                } else {
                    VStack(spacing: 20) {
                        // Header info
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Player: \(playerName)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("Time Left: \(timeLeft)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 5) {
                                Text("Score: \(gameController.score)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("High Score: \(gameController.highScore)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        
                        Divider()
                            .background(Color.secondary)
                            .padding(.horizontal, 10)
                        
                        // Game Area
                        GeometryReader { geometry in
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .padding(.horizontal, 10)
                                    .cornerRadius(20)
                                
                                ForEach(gameController.bubbles) { bubble in
                                    Circle()
                                        .fill(bubble.color.color)
                                        .frame(width: 80, height: 80)
                                        .position(bubble.position)
                                        .onTapGesture {
                                            print("Popped \(bubble.color)")
                                            
                                            gameController.popBubble(bubble: bubble)
                                        }
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // delays bubble generation by 0.1s to avoid swiftui not loading in before bubbles
                                    gameController.generateBubbles(in: geometry.size)
                                }
                            }
                            .onChange(of: timeLeft) { _ in
                                // call refresh bubbles every 1s
                                gameController.refreshBubbles(in: geometry.size)
                            }
                        }
                    }
                    // fade out anim
                    .opacity(fadeOut ? 0 : 1)
                    .onChange(of: timeLeft) { newTimeLeft in
                        if newTimeLeft == 0 {
                            withAnimation(.easeOut(duration: 1.0)) {
                                fadeOut = true
                            }
                        }
                    }
                }
            }
            .onAppear { // as gameview opens
                startTimer()
            }
            .onDisappear { // as gameview closes
                stopTimer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        // Game over
        isGameOver = true
        
        // Update the player's high score
        ScoreManager.shared.updateScore(for: playerName, score: gameController.score)
    }
}



// TO DO LIST (ignore):

// show highscore during gameplay

// 3,2,1 countdown (point values, hints)
// animations when popping/generating bubbles
// score changes/combo length display with animations in response to taps
