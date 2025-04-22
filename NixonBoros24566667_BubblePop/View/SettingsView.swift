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
    
    var body: some View {
        ZStack {
            // bg
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()

                Text("Game Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Stepper(value: $gameController.gameModel.gameTime, in: 10...300, step: 10) {
                    Text("Game Time: \(gameController.gameModel.gameTime) sec")
                        .font(.headline)
                }
                
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                Stepper(value: $gameController.gameModel.maxBubbles, in: 1...50) {
                    Text("Max Bubbles: \(gameController.gameModel.maxBubbles)")
                        .font(.headline)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                NavigationLink(destination: GameView(playerName: gameController.gameModel.playerName, gameTime: gameController.gameModel.gameTime, maxBubbles: gameController.gameModel.maxBubbles), isActive: $startGame) {
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
