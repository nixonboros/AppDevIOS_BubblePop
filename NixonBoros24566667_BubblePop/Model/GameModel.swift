//
//  GameModel.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 9/4/2025.
//

import SwiftUI

class GameModel: ObservableObject {
    @Published var playerName: String = ""
    @Published var gameTime: Int = 60
    @Published var maxBubbles: Int = 15
}
