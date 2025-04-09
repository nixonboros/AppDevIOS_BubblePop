//
//  ContentView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameController = GameController()
    @State private var showSettings = false  // Controls navigation

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color(hue: 0.098, saturation: 0.062, brightness: 1.0))
                    .ignoresSafeArea()
                
                VStack {
                    Text("Bubble Pop")
                        .fontWeight(.bold)
                        .padding()
                        .font(.largeTitle)
                    
                    TextField("Enter Name", text: $gameController.playerName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .font(.headline)
                        .shadow(radius: 5)
                    
                    NavigationLink(destination: SettingsView(gameController: gameController), isActive: $showSettings) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        showSettings = true
                    }) {
                        Text("New Game")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(gameController.playerName.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                    }
                    .disabled(gameController.playerName.isEmpty)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
