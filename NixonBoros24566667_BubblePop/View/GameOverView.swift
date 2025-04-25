//
//  GameOverView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Monica Boros on 25/4/2025.
//

import SwiftUI

struct GameOverView: View {
    let playerName: String
    let finalScore: Int
    var highScore: Int {
        ScoreManager.shared.getHighScore(for: playerName)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .shadow(radius: 2)

                VStack(spacing: 10) {
                    Text("Player: \(playerName)")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Final Score: \(finalScore)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 40)
                
                Divider()
                    .background(Color.secondary)
                    .padding(.horizontal, 40)

                VStack(spacing: 10) {
                    Text("High Score:")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text("\(highScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .shadow(radius: 1)
                }
                .padding(.horizontal, 40)

                Spacer() // Push the "Back to Menu" button to the bottom

                NavigationLink(destination: ContentView(gameController: GameController(gameModel: GameModel()))) {
                    Text("Back to Menu")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
