//
//  LeaderboardView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 22/4/2025.
//

import SwiftUI

struct LeaderboardView: View {
    let scores = ScoreManager.shared.getAllScores()

    var body: some View {
        ZStack {
            // bg gradient
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.yellow.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("🏆 Leaderboard")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 5)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(Array(scores.sorted(by: { $0.value > $1.value }).enumerated()), id: \.element.key) { index, entry in
                            HStack {
                                Text("#\(index + 1)")
                                    .font(.title3.bold())
                                    .foregroundColor(.yellow)

                                Text(entry.key)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Spacer()

                                Text("\(entry.value)")
                                    .font(.title2.bold())
                                    .foregroundColor(.green)
                            }
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(15)
                            .shadow(radius: 3)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()
            }
            .padding(.top, 30)
        }
    }
}
