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
        ZStack {
            Rectangle()
                .fill(Color(hue: 0.098, saturation: 0.062, brightness: 1.0))
                .ignoresSafeArea()
            
            VStack {
                if gameController.isGameStarted {
                    GameView(playerName: gameController.playerName)
                } else {
                    // Main Menu Screen
                    Text("Bubble Pop")
                        .fontWeight(.bold)
                        .padding()
                        .font(.largeTitle)
                    
                    TextField("Enter Name", text: $gameController.playerName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .font(.headline)
                        .shadow(radius: 5)
                    
                    Button(action: {
                        gameController.startGame()
                    }) {
                        Text("Start Game")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(gameController.playerName.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                    }
                    .padding()
                    .disabled(gameController.playerName.isEmpty) // Disable button when playerName is empty
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
