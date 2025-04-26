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
    
    var body: some View {
        NavigationStack {
            ZStack {
                // bg gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple.opacity(0.8)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // game title
                    Text("Bubble Pop")
                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)

                    // name input
                    TextField("Enter your name", text: $gameController.gameModel.playerName)
                        .padding()
                        .background(.white.opacity(0.2))
                        .foregroundColor(.white)
                        .font(.title2.bold())
                        .cornerRadius(30)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(.white.opacity(0.4), lineWidth: 1))
                        .padding(.horizontal, 40)
                        .shadow(radius: 5)

                    // new game button
                    Button(action: {
                        gameController.updatePlayerName(newName: gameController.gameModel.playerName)
                        showSettings = true
                    }) {
                        Text("New Game")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(gameController.gameModel.playerName.isEmpty ? Color.gray : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                            .scaleEffect(gameController.gameModel.playerName.isEmpty ? 1.0 : 1.03)
                            .animation(.easeInOut(duration: 0.4), value: gameController.gameModel.playerName.isEmpty)
                    }
                    .disabled(gameController.gameModel.playerName.isEmpty)
                    .padding(.horizontal, 40)

                    // navigationlink to settingsview
                    NavigationLink(destination: SettingsView(gameController: gameController),
                                   isActive: $showSettings) {
                    }

                    // leaderboard button
                    NavigationLink(destination: LeaderboardView()) {
                        VStack(spacing: 8) {
                            Image(systemName: "trophy.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.yellow)
                                .padding(15)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .shadow(radius: 10)

                            Text("Leaderboard")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 30)
                        .scaleEffect(1.1)
                    }

                    Spacer()
                }
                .padding(.bottom, 30)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView(gameController: GameController(gameModel: GameModel()))
}

// TO DO LIST (ignore):

// 3,2,1 countdown (point values, hints)
// animations when popping/generating bubbles
// score changes/combo length display with animations in response to taps
