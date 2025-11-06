//
//  GameView.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI
import DesignSystem

struct GameView<VM: GameViewModelProtocol>: View {
    @StateObject var vm: VM
    @State private var showWinAnimation = false
    @State private var winner: Player? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                // 🌈 Fond dégradé
                LinearGradient(
                    colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                   

                    if !vm.gameStarted {
                        PlayerSelectionView(vm: vm)
                            .padding(.bottom, 20) // Optionnel : un peu d’espace entre boutons et header
                    } else {
                        GamePlayingView(vm: vm)
                    }

                    GameHeaderView() // ← Maintenant en bas, juste après les boutons

                    // --- Animation de victoire ---
                    if showWinAnimation, let winner = winner {
                        VictoryAnimationView(winner: winner)
                            .transition(.scale.combined(with: .opacity))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation {
                                        showWinAnimation = false
                                    }
                                }
                            }
                    }
                }
                .padding(.horizontal) // Ajoute un padding horizontal global si besoin
            }
            .navigationTitle("TicTacToe")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: vm.showWinnerAlert) { _ in
                if let w = vm.model.winner {
                    winner = w
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showWinAnimation = true
                    }
                }
            }
            .alert(isPresented: Binding(get: { vm.showWinnerAlert }, set: { vm.showWinnerAlert = $0 })) {
                Alert(
                    title: Text("Victoire 🎉"),
                    message: Text("Le joueur \(vm.model.winner?.rawValue ?? "?") a gagné !"),
                    dismissButton: .default(Text("OK")) {
                        vm.restartGame()
                    }
                )
            }
            .alert(isPresented: Binding(get: { vm.showDrawAlert }, set: { vm.showDrawAlert = $0 })) {
                Alert(
                    title: Text("Match nul 🤝"),
                    message: Text("Personne n’a gagné cette fois !"),
                    dismissButton: .default(Text("Rejouer")) {
                        vm.restartGame()
                    }
                )
            }
        }
    }
}


private struct GameHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: HistoryView()) {
                Text("Historique des parties")
                    .bold()
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(8)
            }
            Spacer()
        }
    }
}

private struct PlayerSelectionView<VM: GameViewModelProtocol>: View {
    let vm: VM
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choisis ton symbole")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 20)

            HStack(spacing: 24) {
                PrimaryButton(
                    vm: PrimaryButtonViewModel(
                        title: "Jouer avec X",
                        action: { vm.chooseStartingPlayer(.x) }
                    )
                )
                PrimaryButton(
                    vm: PrimaryButtonViewModel(
                        title: "Jouer avec O",
                        action: { vm.chooseStartingPlayer(.o) }
                    )
                )
            }
        }
        .padding()
    }
}

private struct GamePlayingView<VM: GameViewModelProtocol>: View {
    @ObservedObject var vm: VM
    @ObservedObject var scoreManager = ScoreManager.shared

    var body: some View {
        VStack(spacing: 20) {
            // Scores
            HStack(spacing: 40) {
                VStack {
                    Text("Joueur X")
                        .foregroundColor(.white)
                    Text("\(scoreManager.scoreX)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                }
                VStack {
                    Text("Joueur O")
                        .foregroundColor(.white)
                    Text("\(scoreManager.scoreO)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                }
            }
            .padding(.bottom, 10)

            Text("Tour du joueur : \(vm.model.currentPlayer.rawValue)")
                .font(.headline)
                .foregroundColor(.white)

            GameBoardView(vm: vm)
                .padding(20)

            PrimaryButton(
                vm: PrimaryButtonViewModel(
                    title: "Recommencer",
                    action: { vm.restartGame() }
                )
            )

            Button("Changer de symbole") {
                vm.resetToChoosePlayer()
                scoreManager.resetScores()
            }
            .font(.footnote)
            .padding(.top, 8)
            .foregroundColor(.white)

            Button("Finir la partie") {
                vm.finishSession()
            }
            .padding(.top, 8)
            .foregroundColor(.white)
        }
        .padding()
    }
}
