//
//  GameView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 25/3/2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var gameController: GameController

    let playerName: String
    let maxBubbles: Int

    @State private var timeLeft: Int
    @State private var timer: Timer? = nil
    @State private var isGameOver: Bool = false
    @State private var bubbleScales: [UUID: CGFloat] = [:]
    @State private var isPressed: [UUID: Bool] = [:]

    @State private var fadeIn: Bool = false
    @State private var fadeOut: Bool = false

    init(playerName: String, gameTime: Int, maxBubbles: Int) {
        self.playerName = playerName
        self.maxBubbles = maxBubbles
        _timeLeft = State(initialValue: gameTime)

        let gameModel = GameModel(playerName: playerName, gameTime: gameTime, maxBubbles: maxBubbles)
        _gameController = StateObject(wrappedValue: GameController(gameModel: gameModel))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if isGameOver {
                    GameOverView(
                        playerName: playerName,
                        finalScore: gameController.score,
                        gameTime: gameController.gameModel.gameTime,
                        maxBubbles: gameController.gameModel.maxBubbles
                    )
                        .opacity(fadeIn ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                fadeIn = true
                            }
                        }
                } else {
                    // bg gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.85), Color.white.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()

                    // game view
                    VStack(spacing: 20) {
                        // header info
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Player: \(playerName)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)

                                Text("Time Left: \(timeLeft)")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .shadow(radius: 1)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 5) {
                                Text("Score: \(gameController.score)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)

                                Text("High Score: \(gameController.highScore)")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .shadow(radius: 1)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)

                        Divider()
                            .background(.white)
                            .padding(.horizontal, 10)

                        // game area
                        GeometryReader { geometry in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.3))
                                    .padding(.horizontal, 10)

                                ForEach(gameController.bubbles) { bubble in
                                    Circle()
                                        .fill(bubble.color.color)
                                        .frame(width: 80, height: 80)
                                        .scaleEffect(bubbleScales[bubble.id] ?? 1.0) // use the bubble's scale
                                        .position(bubble.position)
                                        .shadow(radius: 5)
                                        .onAppear {
                                            // when bubble appears, start with small scale and animate to full size
                                            bubbleScales[bubble.id] = 0.0
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                bubbleScales[bubble.id] = 1.0
                                            }
                                        }
                                        .onTapGesture {
                                            // check if the bubble is pressed. If it is, do nothing (avoids taps while bubble pop animation is playing)
                                                guard isPressed[bubble.id] == nil || isPressed[bubble.id] == false else { return }
                                            
                                            // mark the bubble as animating
                                                isPressed[bubble.id] = true
                                            
                                            // when tapped, shrink and then pop
                                            withAnimation(.easeIn(duration: 0.1)) {
                                                bubbleScales[bubble.id] = 0.0
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                gameController.popBubble(bubble: bubble)
                                                bubbleScales.removeValue(forKey: bubble.id)
                                                isPressed[bubble.id] = false
                                            }
                                        }
                                }

                                // display points gained when a bubble is tapped
                                ForEach(gameController.pointOverlays, id: \.position) { overlay in
                                    Text("+\(overlay.points)")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .bold()
                                        .shadow(color: .black.opacity(0.7), radius: 3, x: 1, y: 1)
                                        .position(overlay.position)
                                        .opacity(overlay.opacity)
                                        .onAppear {
                                            withAnimation(.easeOut(duration: 0.4)) {
                                                if let index = gameController.pointOverlays.firstIndex(where: { $0.position == overlay.position }) {
                                                    gameController.pointOverlays[index].opacity = 0 // animate to 0 opacity
                                                }
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                if let index = gameController.pointOverlays.firstIndex(where: { $0.position == overlay.position }) {
                                                    gameController.pointOverlays.remove(at: index)
                                                }
                                            }
                                        }
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    gameController.generateBubbles(in: geometry.size)
                                }
                            }
                            .onChange(of: timeLeft) { _ in
                                // refresh bubbles every 1s
                                gameController.refreshBubbles(in: geometry.size)
                            }
                        }
                    }
                    .opacity(fadeOut ? 0 : 1)
                    .onChange(of: timeLeft) { newTimeLeft in
                        if newTimeLeft == 0 {
                            withAnimation(.easeOut(duration: 1.0)) {
                                fadeOut = true
                            }
                        }
                    }
                }
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer() // saves and/or updates score to highscores.json
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        // game over
        isGameOver = true
        
        // update the player's high score
        ScoreManager.shared.updateScore(for: playerName, score: gameController.score)
    }
}
