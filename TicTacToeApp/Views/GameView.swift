//
//  Untitled.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

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
        ZStack {
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
                        // --- Sélection du joueur ---
                        VStack(spacing: 20) {
                            Text("Choisis ton symbole")
                                .font(.title2)
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
                    } else {
                        // --- Plateau du jeu ---
                        VStack(spacing: 20) {
                            Text("Tour du joueur : \(vm.model.currentPlayer.rawValue)")
                                .font(.headline)
                            
                            GameBoardView(vm: vm)
                            
                            PrimaryButton(
                                vm: PrimaryButtonViewModel(
                                    title: "Recommencer",
                                    action: { vm.restartGame() }
                                )
                            )

                            
                            Button("Changer de symbole") {
                                vm.restartGame()
                            }
                            .font(.footnote)
                            .padding(.top, 8)
                        }
                        .padding()
                    }
                }
                
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
            // Quand la victoire est détectée
            .onChange(of: vm.showWinnerAlert) { newValue in
                if newValue {
                    winner = vm.model.winner
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showWinAnimation = true
                    }
                }
            }
            // Alertes
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
            .navigationTitle("TicTacToe")
        }
    }
    
    
}
