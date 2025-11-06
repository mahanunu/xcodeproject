//
//  ScoreManager.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 06/11/2025.
//

import Foundation
import SwiftUI

final class ScoreManager: ObservableObject {
    static let shared = ScoreManager()
    private let defaults = UserDefaults.standard

    @Published var scoreX: Int {
        didSet { defaults.set(scoreX, forKey: "score_player_x") }
    }

    @Published var scoreO: Int {
        didSet { defaults.set(scoreO, forKey: "score_player_o") }
    }

    private init() {
        self.scoreX = defaults.integer(forKey: "score_player_x")
        self.scoreO = defaults.integer(forKey: "score_player_o")
    }

    func addWin(for player: Player) {
        switch player {
        case .x: scoreX += 1
        case .o: scoreO += 1
        }
    }

    func resetScores() {
        scoreX = 0
        scoreO = 0
    }
}

