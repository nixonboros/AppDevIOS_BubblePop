import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameController: GameController
    @State private var gameTime: Int = 60
    @State private var maxBubbles: Int = 15
    @State private var startGame = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGroupedBackground))
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()

                Text("Game Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Stepper(value: $gameTime, in: 10...300, step: 10) {
                    Text("Game Time: \(gameTime) sec")
                        .font(.headline)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                Stepper(value: $maxBubbles, in: 1...50) {
                    Text("Max Bubbles: \(maxBubbles)")
                        .font(.headline)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .shadow(radius: 2)

                NavigationLink(destination: GameView(playerName: gameController.playerName), isActive: $startGame) {
                    EmptyView()
                }

                Button(action: {
                    gameController.gameTime = gameTime
                    gameController.maxBubbles = maxBubbles
                    startGame = true
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
        }
    }
}
