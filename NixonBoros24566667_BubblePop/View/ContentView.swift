//
//  ContentView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameController: GameController
    @State private var showSettings = false
    @State private var showLeaderboard = false

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGroupedBackground))
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    Spacer()

                    Text("Bubble Pop")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    TextField("Enter Name", text: $gameController.gameModel.playerName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                        .font(.headline)
                        .shadow(radius: 2)

                    NavigationLink(destination: SettingsView(gameController: gameController), isActive: $showSettings) {
                        EmptyView()
                    }

                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            gameController.updatePlayerName(newName: gameController.gameModel.playerName)
                            showSettings = true
                        }
                    }) {
                        Text("New Game")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(gameController.gameModel.playerName.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal, 40)
                    }
                    .disabled(gameController.gameModel.playerName.isEmpty)
                    .animation(.easeInOut(duration: 0.3), value: gameController.gameModel.playerName)

                    // Leaderboard icon centered under button
                    NavigationLink(destination: LeaderboardView()) {
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView(gameController: GameController(gameModel: GameModel()))
}
