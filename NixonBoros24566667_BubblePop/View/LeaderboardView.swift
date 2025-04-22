//
//  LeaderboardView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 22/4/2025.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            Text("Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}
