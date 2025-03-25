//
//  ContentView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameController = GameController()
    
    var body: some View {
        VStack {
            if gameController.isGameStarted {
                GameView(playerName: gameController.playerName)
            } else {
                // Main Menu Screen
                TextField("Enter Name", text: $gameController.playerName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.horizontal)
                
                Button(action: {
                    gameController.startGame()
                }) {
                    Text("Start Game")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
