//
//  CountdownView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Nixon Boros on 26/4/2025.
//

import SwiftUI

struct CountdownView: View {
    @State private var countdown = 3
    @State private var opacity = 1.0
    var onComplete: () -> Void

    var body: some View {
        ZStack {
            // background
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.8)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // countdown number
                Text("\(countdown)")
                    .font(.system(size: 100, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .scaleEffect(1.5)
                    .onAppear {
                        startCountdown()
                    }

                // point value hints
                VStack(spacing: 12) {
                    HStack(spacing: 15) {
                        Circle().fill(Color.red).frame(width: 20, height: 20)
                        Text("Red: 1 point").foregroundColor(.white)
                    }

                    HStack(spacing: 15) {
                        Circle().fill(Color(red: 1.0, green: 0.5, blue: 0.7)).frame(width: 20, height: 20)
                        Text("Pink: 2 points").foregroundColor(.white)
                    }

                    HStack(spacing: 15) {
                        Circle().fill(Color.green).frame(width: 20, height: 20)
                        Text("Green: 5 points").foregroundColor(.white)
                    }

                    HStack(spacing: 15) {
                        Circle().fill(Color.blue).frame(width: 20, height: 20)
                        Text("Blue: 8 points").foregroundColor(.white)
                    }

                    HStack(spacing: 15) {
                        Circle().fill(Color.black).frame(width: 20, height: 20)
                        Text("Black: 10 points").foregroundColor(.white)
                    }

                    Divider().background(Color.white)

                    Text("Colour Streak: 1.5x points")
                        .foregroundColor(.yellow)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal, 40)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.5)) {
                opacity = 0.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                countdown -= 1
                opacity = 1.0

                if countdown == 0 {
                    timer.invalidate()
                    withAnimation {
                        onComplete()
                    }
                }
            }
        }
    }
}
