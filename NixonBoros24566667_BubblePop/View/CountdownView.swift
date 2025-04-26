//
//  CountdownView.swift
//  NixonBoros24566667_BubblePop
//
//  Created by Monica Boros on 26/4/2025.
//

import SwiftUI

struct CountdownView: View {
    @State private var countdown = 3
    @State private var opacity = 1.0
    var onComplete: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Text("\(countdown)")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(opacity)
                .scaleEffect(1.5)
                .onAppear {
                    startCountdown()
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
