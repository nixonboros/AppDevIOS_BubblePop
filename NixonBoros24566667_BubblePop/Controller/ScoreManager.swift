//
//  ScoreManager.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Monica Boros on 25/4/2025.
//

import Foundation

class ScoreManager {
    static let shared = ScoreManager()
    private let fileName = "highscores.json"

    private var scores: [String: Int] = [:] // playerName : highScore

    init() {
        loadScores()
    }

    private func getFileURL() -> URL? {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }

    private func loadScores() {
        guard let url = getFileURL(),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: Int].self, from: data)
        else {
            return
        }

        scores = decoded
    }

    private func saveScores() {
        guard let url = getFileURL(),
              let data = try? JSONEncoder().encode(scores)
        else {
            return
        }

        try? data.write(to: url)
    }

    func getHighScore() -> Int {
        return scores.values.max() ?? 0
    }

    func updateScore(for playerName: String, score: Int) {
        let currentHigh = scores[playerName] ?? 0
        if score > currentHigh {
            scores[playerName] = score
            saveScores()
        }
    }
    
    func getAllScores() -> [String: Int] {
        return scores
    }
}
