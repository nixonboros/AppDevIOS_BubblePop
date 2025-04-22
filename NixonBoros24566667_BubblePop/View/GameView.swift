//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    let playerName: String
    let maxBubbles: Int

    @State private var timeLeft: Int
    @State private var timer: Timer? = nil

    init(playerName: String, gameTime: Int, maxBubbles: Int) {
        self.playerName = playerName
        self.maxBubbles = maxBubbles
        _timeLeft = State(initialValue: gameTime)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header info
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Player: \(playerName)")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text("Time Left: \(timeLeft)")
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

                // Placeholder game area
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
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    // MARK: - Timer Logic

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                stopTimer()
                // Placeholder for when timer hits 0
                print("Timer reached 0 — placeholder action")
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
