//
//  GameOverView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/4/2025.
//

import SwiftUI

struct GameOverView: View {
    @State private var showGameView = false
    @State private var showCountdown = false
    @State private var goToMenu = false
    @State private var showLeaderboard = false
    
    let playerName: String
    let finalScore: Int
    let gameTime: Int
    let maxBubbles: Int

    var highScore: Int {
        ScoreManager.shared.getHighScore()
    }

    var body: some View {
        ZStack {
            if showGameView {
                // after countdown finishes, start game
                GameView(
                    playerName: playerName,
                    gameTime: gameTime,
                    maxBubbles: maxBubbles
                )
                .transition(.opacity)
            }
            else if showCountdown {
                // show countdown first
                CountdownView {
                    withAnimation {
                        showCountdown = false
                        showGameView = true
                    }
                }
                .transition(.opacity)
            }
            else if goToMenu {
                // back to menu
                ContentView(gameController: GameController(gameModel: GameModel()))
                    .transition(.opacity)
            }
            else {
                // background gradient
                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.orange]),
                               startPoint: .top,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                // game over screen
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Game Over")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    VStack(spacing: 12) {
                        Text("Player: \(playerName)")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Final Score: \(finalScore)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal, 40)

                    Divider()
                        .background(Color.white.opacity(0.5))
                        .padding(.horizontal, 60)

                    VStack(spacing: 10) {
                        Text("High Score")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))

                        Text("\(highScore)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                    }

                    Spacer()

                    // retry Button
                    Button(action: {
                        withAnimation {
                            showCountdown = true
                        }
                    }) {
                        Image(systemName: "gobackward")
                            .font(.system(size: 28, weight: .bold))
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 40)

                    // back to Menu Button
                    Button(action: {
                        withAnimation {
                            goToMenu = true
                        }
                    }) {
                        Text("Back to Menu")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 4)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 10)
                    }

                    // view Leaderboard Button
                    Button(action: {
                        showLeaderboard = true
                    }) {
                        Text("View Leaderboard")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 4)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 30)
                    }
                    .sheet(isPresented: $showLeaderboard) {
                        LeaderboardView()
                            .presentationDetents([.fraction(0.99), .large])
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .animation(.easeInOut, value: showCountdown)
        .animation(.easeInOut, value: showGameView)
        .animation(.easeInOut, value: goToMenu)
    }
}
