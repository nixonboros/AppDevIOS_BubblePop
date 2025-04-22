//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    let playerName: String
    let gameTime: Int
    let maxBubbles: Int

    var body: some View {
        ZStack {
            // bg
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // header info (player name, time left, score, high score)
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Player: \(playerName)")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text("Time Left: \(gameTime)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Score: 0")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text("High Score: 0")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 40)

                Spacer()

                // placeholder for game area
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 20)
                    .overlay(Text("Game Area")
                        .font(.title3)
                        .foregroundColor(.gray))

                Spacer()
            }
        }
    }
}

