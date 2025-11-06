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
    
    // --- Choisir le joueur qui commence ---
    func chooseStartingPlayer(_ player: Player) {
        startingPlayer = player
        model.reset(with: player)
        gameStarted = true
    }
    
    // --- Jouer un coup ---
    func makeMove(at index: Int) {
        guard gameStarted else { return } // ignore si la partie n'a pas commencé
        model.makeMove(at: index)
        
        if let winner = model.winner {
            showWinnerAlert = true
            ScoreManager.shared.addWin(for: winner)
        } else if model.isBoardFull() {
            showDrawAlert = true

        }
    }
    
    // --- Recommencer la partie en conservant le joueur de départ ---
    func restartGame() {
        model.reset(with: startingPlayer)
        showWinnerAlert = false
        showDrawAlert = false
        gameStarted = true
    }
    
    // --- Revenir à l'écran de choix du joueur ---
    func resetToChoosePlayer() {
        gameStarted = false
        model.reset(with: .x) // ou un état neutre si tu préfères
        showWinnerAlert = false
        showDrawAlert = false
    }
    
    // --- Réinitialiser les scores ---
    func resetScores() {
        ScoreManager.shared.resetScores()
    }
    
        func finishSession() {
        HistoryManager.shared.recordSession(
            playerXName: "X",
            playerOName: "O",
            scoreX: ScoreManager.shared.scoreX,
            scoreO: ScoreManager.shared.scoreO
        )
        
        // Optionnel : réinitialiser les scores après sauvegarde
        ScoreManager.shared.resetScores()
        
        // Revenir à l'écran de choix
        resetToChoosePlayer()
    }
}
