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
    let highScore: Int // Placeholder for now
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
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

                Spacer()

                Button(action: {
                    // TODO: Hook up to navigate back to main menu
                    print("Back to Menu or Restart Game")
                }) {
                    Text("Back to Menu")
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

#Preview {
    GameOverView(playerName: "Nixon", finalScore: 250, highScore: 0)
}
