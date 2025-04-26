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
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                Text("⚙️ Game Settings")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 4)

                VStack(spacing: 20) {
                    Stepper(value: $gameController.gameModel.gameTime, in: 10...300, step: 10) {
                        Text("Game Time: \(gameController.gameModel.gameTime) sec")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .onChange(of: gameController.gameModel.gameTime) { newValue in
                        gameController.updateGameTime(gameTime: newValue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.15))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.3)))
                    .shadow(radius: 4)

                    Stepper(value: $gameController.gameModel.maxBubbles, in: 1...15) {
                        Text("Max Bubbles: \(gameController.gameModel.maxBubbles)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .onChange(of: gameController.gameModel.maxBubbles) { newValue in
                        gameController.updateMaxBubbles(maxBubbles: newValue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.15))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.3)))
                    .shadow(radius: 4)

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
                    withAnimation {
                        startGame = true
                    }
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 6)
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
        }
    }
}
