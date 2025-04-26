//
//  SettingsView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 9/4/2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameController: GameController
    @State private var showCountdown = false
    @State private var showGameView = false

    let defaultGameTime = 60
    let defaultMaxBubbles = 15

    var isModified: Bool {
        gameController.gameModel.gameTime != defaultGameTime ||
        gameController.gameModel.maxBubbles != defaultMaxBubbles
    }

    var body: some View {
        ZStack {
            if showGameView {
                GameView(
                    playerName: gameController.gameModel.playerName,
                    gameTime: gameController.gameModel.gameTime,
                    maxBubbles: gameController.gameModel.maxBubbles
                )
                .transition(.opacity)
            }
            else if showCountdown {
                CountdownView {
                    withAnimation {
                        showCountdown = false
                        showGameView = true
                    }
                }
                .transition(.opacity)
            }
            else {
                // background gradient
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // page title
                    Text("⚙️ Game Settings")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)

                    VStack(spacing: 20) {
                        // game time stepper
                        Stepper(value: $gameController.gameModel.gameTime, in: 10...300, step: 10) {
                            Text("Game Time: \(gameController.gameModel.gameTime) sec")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .onChange(of: gameController.gameModel.gameTime) { newValue in
                            gameController.updateGameTime(gameTime: newValue)
                        }
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.3), lineWidth: 1))
                        .shadow(radius: 4)

                        // max bubbles stepper
                        Stepper(value: $gameController.gameModel.maxBubbles, in: 1...15) {
                            Text("Max Bubbles: \(gameController.gameModel.maxBubbles)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .onChange(of: gameController.gameModel.maxBubbles) { newValue in
                            gameController.updateMaxBubbles(maxBubbles: newValue)
                        }
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.3), lineWidth: 1))
                        .shadow(radius: 4)

                        // reset button
                        Button(action: {
                            gameController.updateGameTime(gameTime: defaultGameTime)
                            gameController.updateMaxBubbles(maxBubbles: defaultMaxBubbles)
                            gameController.objectWillChange.send()
                        }) {
                            Text("Reset to Default")
                                .font(.subheadline)
                                .foregroundColor(isModified ? .yellow : .gray)
                        }
                        .disabled(!isModified)
                    }
                    .padding(.horizontal, 40)

                    // start game button
                    Button(action: {
                        withAnimation {
                            showCountdown = true
                        }
                    }) {
                        Text("Start Game")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
                .padding(.bottom, 30)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .animation(.easeInOut, value: showCountdown)
        .animation(.easeInOut, value: showGameView)
        .navigationBarBackButtonHidden(true)
    }
}
