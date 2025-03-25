//
//  GameController.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

class GameController: ObservableObject {
    @Published var playerName: String = ""
    @Published var isGameStarted: Bool = false
    
    func startGame() {
        // Validate name entry
        if playerName.isEmpty {
            playerName = "EmptyPlayerName" // Use a default name if empty
        }
        
        isGameStarted = true
    }
}
