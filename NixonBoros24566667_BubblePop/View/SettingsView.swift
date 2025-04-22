//
//  SettingsView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 9/4/2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameController: GameController
    @State private var startGame = false
    
    // Define default values for game time and max bubbles
    let defaultGameTime = 60
    let defaultMaxBubbles = 15

    // Computed property to check if values have been modified
    var isModified: Bool {
        gameController.gameModel.gameTime != defaultGameTime ||
        gameController.gameModel.maxBubbles != defaultMaxBubbles
    }

    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                // Title
                Text("Game Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // Game Time Stepper
                Stepper(value: $gameController.gameModel.gameTime, in: 10...300, step: 10) {
                    Text("Game Time: \(gameController.gameModel.gameTime) sec")
                        .font(.headline)
                }
                .onChange(of: gameController.gameModel.gameTime) { newValue in
                    gameController.updateGameTime(gameTime: newValue)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                // Max Bubbles Stepper
                Stepper(value: $gameController.gameModel.maxBubbles, in: 1...50) {
                    Text("Max Bubbles: \(gameController.gameModel.maxBubbles)")
                        .font(.headline)
                }
                .onChange(of: gameController.gameModel.maxBubbles) { newValue in
                    gameController.updateMaxBubbles(maxBubbles: newValue)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                Button(action: {
                    // Reset to default values and force refresh
                    gameController.updateGameTime(gameTime: defaultGameTime)
                    gameController.updateMaxBubbles(maxBubbles: defaultMaxBubbles)
                    
                    // Force UI update by manually updating a state variable
                    gameController.objectWillChange.send() // force view to refresh
                }) {
                    Text("Reset to Default")
                        .font(.subheadline)
                        .foregroundColor(isModified ? .blue : .gray) // Change color based on modification status
                        .underline()
                }
                .padding(.top, 10)
                .disabled(!isModified)  // Disable button if no modifications

                // NavigationLink to GameView
                NavigationLink(
                    destination: GameView(
                        playerName: gameController.gameModel.playerName,
                        gameTime: gameController.gameModel.gameTime,
                        maxBubbles: gameController.gameModel.maxBubbles
                    ),
                    isActive: $startGame
                ) {
                    EmptyView()
                }

                // Start Game Button
                Button(action: {
                    startGame = true
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                        .animation(.easeInOut, value: startGame) // Optional: Animation
                }

                Spacer()
            }
        }
    }
}
