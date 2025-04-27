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
                // bg gradient
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
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
                    TextField(
                        "",
                        text: $gameController.gameModel.playerName,
                        prompt: Text("Enter your name")
                            .foregroundColor(.white.opacity(0.6))
                    )
                    .padding()
                    .background(.white.opacity(0.2))
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.white.opacity(0.4), lineWidth: 1)
                    )
                    .padding(.horizontal, 40)
                    .shadow(radius: 5)


                    // new game button
                    Button(action: {
                        gameController.updatePlayerName(newName: gameController.gameModel.playerName)
                        showSettings = true
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.system(size: 28, weight: .bold))
                            Text("New Game")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(gameController.gameModel.playerName.isEmpty ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)
                    }
                    .disabled(gameController.gameModel.playerName.isEmpty)
                    // scale and fade anim on buttton
                    .scaleEffect(gameController.gameModel.playerName.isEmpty ? 1.0 : 1.05)
                    .animation(.easeInOut(duration: 0.4), value: gameController.gameModel.playerName.isEmpty)

                    // navigationlink to settingsview
                    NavigationLink(destination: SettingsView(gameController: gameController),
                                   isActive: $showSettings) {
                    }

                    // leaderboard button
                    Button(action: {
                        showLeaderboard = true
                    }) {
                        HStack {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 28, weight: .bold))
                            Text("Leaderboard")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)
                    }
                    .sheet(isPresented: $showLeaderboard) {
                        LeaderboardView()
                            .presentationDetents([.fraction(0.99), .large])
                    }

                    Spacer()
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView(gameController: GameController(gameModel: GameModel()))
}
