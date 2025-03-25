//
//  ContentView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = ""
    @State private var isGameStarted = false
    
    var body: some View {
        VStack {
            if isGameStarted {
                GameView(playerName: playerName)
            } else {
                // Main Menu Screen
                TextField("Enter Name", text: $playerName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.horizontal)
                
                Button(action: {
                    startGame()
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
    
    func startGame() {
        // Validate name entry
        if playerName.isEmpty {
            playerName = "Player" // Use a default name if empty
        }
        
        isGameStarted = true
    }
}

#Preview {
    ContentView()
}
