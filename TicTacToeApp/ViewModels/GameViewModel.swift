//
//  GameViewModel.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//
import Foundation
import SwiftUI

@MainActor
final class GameViewModel: GameViewModelProtocol {
    @Published var model = GameModel()
    @Published var showWinnerAlert = false
    @Published var showDrawAlert = false
    @Published var startingPlayer: Player = .x
    @Published var gameStarted: Bool = false
    @Published var playerXImage: UIImage? = nil
    @Published var playerOImage: UIImage? = nil

    func chooseStartingPlayer(_ player: Player) {
        startingPlayer = player
        model.reset(with: player)
        gameStarted = true                           // <-- démarre la partie
    }

    func makeMove(at index: Int) {
        guard gameStarted else { return }            // ignore si non démarré
        model.makeMove(at: index)

        if model.winner != nil {
            showWinnerAlert = true
        } else if model.isBoardFull() {
            showDrawAlert = true
        }
    }

    func restartGame() {
        model.reset(with: startingPlayer)
        showWinnerAlert = false
        showDrawAlert = false
        gameStarted = true                            // conserve le choix initial
    }

    // Optionnel : une fonction pour revenir au choix initial
    func resetToChoosePlayer() {
        gameStarted = false
        model.reset(with: .x) // ou garder un état neutre
    }
}
