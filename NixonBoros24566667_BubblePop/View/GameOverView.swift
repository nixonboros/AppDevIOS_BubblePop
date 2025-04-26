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
            // bg gradient
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.orange]),
                           startPoint: .top,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                Text("Game Over")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 5)

                VStack(spacing: 12) {
                    Text("Player: \(playerName)")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("Final Score: \(finalScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .shadow(radius: 2)
                }
                .padding(.horizontal, 40)

                Divider()
                    .background(Color.white.opacity(0.5))
                    .padding(.horizontal, 60)

                VStack(spacing: 10) {
                    Text("High Score")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    Text("\(highScore)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                }

                Spacer()

                NavigationLink(destination: ContentView(gameController: GameController(gameModel: GameModel()))) {
                    Text("Back to Menu")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 4)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}


