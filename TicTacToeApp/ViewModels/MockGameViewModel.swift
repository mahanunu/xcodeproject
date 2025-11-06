//
//  MOckGameViewModel.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import Foundation

@MainActor
final class MockGameViewModel: GameViewModelProtocol {
    @Published var model = GameModel(
        board: [.x, .o, .x,
                .o, .x, .o,
                nil, nil, nil],
        currentPlayer: .x,
        winner: nil
    )
    @Published var showWinnerAlert = false
    @Published var showDrawAlert = false
    @Published var gameStarted: Bool = true    

    func chooseStartingPlayer(_ player: Player) { model.reset(with: player); gameStarted = true }
    func makeMove(at index: Int) { /* noop */ }
    func restartGame() { model.reset(with: .x); gameStarted = true }
    func resetToChoosePlayer() {
           gameStarted = false
           model.reset(with: .x)
       }
    func finishSession() {
        model.reset(with: .x)
            showWinnerAlert = false
            showDrawAlert = false
            gameStarted = false    }
}
