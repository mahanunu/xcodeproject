//
//  VictoryAnimationView.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

struct VictoryAnimationView: View {
    let winner: Player

    @State private var animateText = false
    @State private var confettis: [Confetti] = []

    var body: some View {
        ZStack {
            // 🎊 Confettis colorés
            ForEach(confettis) { confetti in
                Circle()
                    .fill(confetti.color)
                    .frame(width: confetti.size, height: confetti.size)
                    .position(confetti.position)
                    .opacity(confetti.opacity)
                    .animation(.easeIn(duration: confetti.duration).delay(confetti.delay), value: confetti.position)
            }

            // ✨ Texte de victoire
            Text("Victoire du joueur \(winner.rawValue) 🎉")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                .shadow(radius: 8)
                .scaleEffect(animateText ? 1 : 0.5)
                .opacity(animateText ? 1 : 0)
                .animation(.spring(duration: 0.8), value: animateText)
        }
        .onAppear {
            launchAnimation()
        }
    }

    private func launchAnimation() {
        // Animation du texte
        animateText = true

        // Création de confettis aléatoires
        let colors: [Color] = [.yellow, .orange, .pink, .blue, .green, .red, .purple]
        confettis = (0..<30).map { _ in
            Confetti(
                position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                  y: CGFloat.random(in: -50...0)),
                color: colors.randomElement()!,
                size: CGFloat.random(in: 8...16),
                delay: Double.random(in: 0...0.5),
                duration: Double.random(in: 1.5...2.5)
            )
        }

        // Fait "tomber" les confettis avec une animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeIn(duration: 2.5)) {
                for i in 0..<confettis.count {
                    confettis[i].position.y = UIScreen.main.bounds.height + 50
                    confettis[i].opacity = 0
                }
            }
        }
    }
}

struct Confetti: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var size: CGFloat
    var delay: Double
    var duration: Double
    var opacity: Double = 1.0
}
