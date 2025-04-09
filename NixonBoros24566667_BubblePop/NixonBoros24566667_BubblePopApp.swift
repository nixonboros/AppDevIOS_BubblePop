//
//  NixonBoros24566667_BubblePopApp.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

@main
struct NixonBoros24566667_BubblePopApp: App {
    @StateObject var gameController = GameController(gameModel: GameModel())
    
    var body: some Scene {
        WindowGroup {
            ContentView(gameController: gameController)
        }
    }
}
