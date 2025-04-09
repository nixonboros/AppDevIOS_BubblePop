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
    
    @Published var gameTime: Int = 60
    @Published var maxBubbles: Int = 15
    
    func startGame() {
            isGameStarted = true
    }
}
