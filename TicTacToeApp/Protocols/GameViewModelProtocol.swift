//
//  Untitled.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import Foundation

@MainActor
protocol GameViewModelProtocol: ObservableObject {
    var model: GameModel { get set }
    var showWinnerAlert: Bool { get set }
    var showDrawAlert: Bool { get set }
    var gameStarted: Bool { get set }         

    func chooseStartingPlayer(_ player: Player)
    func makeMove(at index: Int)
    func restartGame()
    func resetToChoosePlayer()
    func finishSession()
}
