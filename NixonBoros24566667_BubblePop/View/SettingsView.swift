//
//  SettingsView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 9/4/2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameController: GameController
    @State private var gameTime: Int = 60
    @State private var maxBubbles: Int = 15
    @State private var startGame = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Stepper("Game Time: \(gameTime) sec", value: $gameTime, in: 10...300, step: 10)
                .padding()
            
            Stepper("Max Bubbles: \(maxBubbles)", value: $maxBubbles, in: 1...50)
                .padding()
            
            NavigationLink(destination: GameView(playerName: gameController.playerName), isActive: $startGame) {
                EmptyView()
            }
            
            Button(action: {
                // Save settings if needed
                gameController.gameTime = gameTime
                gameController.maxBubbles = maxBubbles
                startGame = true
            }) {
                Text("Start Game")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(30)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .padding()
    }
}
