//
//  LeaderboardView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 22/4/2025.
//

//
//  LeaderboardView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 22/4/2025.
//

import SwiftUI

struct LeaderboardView: View {
    // Fetch the scores from ScoreManager
    let scores = ScoreManager.shared.getAllScores()

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()

            VStack {
                Text("Leaderboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                // display leaderboard
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(scores.sorted(by: { $0.value > $1.value }), id: \.key) { player, score in
                            HStack {
                                Text(player)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Spacer()

                                Text("\(score)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.bottom, 40)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}
