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
    
    let defaultGameTime = 60
    let defaultMaxBubbles = 15

    var isModified: Bool {
        gameController.gameModel.gameTime != defaultGameTime ||
        gameController.gameModel.maxBubbles != defaultMaxBubbles
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Text("Game Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

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

                Stepper(value: $gameController.gameModel.maxBubbles, in: 1...15) {
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
                    gameController.updateGameTime(gameTime: defaultGameTime)
                    gameController.updateMaxBubbles(maxBubbles: defaultMaxBubbles)
                    gameController.objectWillChange.send()
                }) {
                    Text("Reset to Default")
                        .font(.subheadline)
                        .foregroundColor(isModified ? .blue : .gray)
                }
                .padding(.top, 10)
                .disabled(!isModified)

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
                }

                Spacer()
            }
        }
    }
}
