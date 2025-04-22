//
//  BubbleModel.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 22/4/2025.
//

import SwiftUI

class BubbleModel: ObservableObject {
    struct Bubble: Identifiable {
        let id = UUID()
        let color: BubbleColour
        var position: CGPoint
    }
    
    enum BubbleColour: CaseIterable {
        case red, pink, green, blue, black
        
        var pointValue: Int {
                switch self {
                case .red: return 1
                case .pink: return 2
                case .green: return 5
                case .blue: return 8
                case .black: return 10
                }
            }

            var appearanceChance: Double {
                switch self {
                case .red: return 0.4
                case .pink: return 0.3
                case .green: return 0.15
                case .blue: return 0.1
                case .black: return 0.05
                }
            }

            var color: Color {
                switch self {
                case .red: return .red
                case .pink: return .pink
                case .green: return .green
                case .blue: return .blue
                case .black: return .black
                }
            }
    }
}
