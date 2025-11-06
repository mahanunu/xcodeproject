
//
//  GameHistory.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 06/11/2025.
//

import Foundation

struct GameHistoryEntry: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let finalScoreX: Int      // ✅ ajout
    let finalScoreO: Int      // ✅ ajout
    let playerXName: String
    let playerOName: String
}
