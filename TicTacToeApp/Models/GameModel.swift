// GameModel.swift

import Foundation

enum Player: String, Codable {
    case x = "X"
    case o = "O"
}

struct GameModel {
    var board: [Player?] = Array(repeating: nil, count: 9)
    var currentPlayer: Player = .x
    var winner: Player? = nil

    mutating func makeMove(at index: Int) {
        guard board[index] == nil, winner == nil else { return }
        board[index] = currentPlayer
        checkWinner()
        if winner == nil {
            currentPlayer = (currentPlayer == .x) ? .o : .x
        }
    }

    mutating func reset(with startingPlayer: Player) {
        board = Array(repeating: nil, count: 9)
        winner = nil
        currentPlayer = startingPlayer
    }

    mutating func checkWinner() {
        let winningCombos = [
            [0,1,2], [3,4,5], [6,7,8],
            [0,3,6], [1,4,7], [2,5,8],
            [0,4,8], [2,4,6]
        ]

        for combo in winningCombos {
            if let p = board[combo[0]],
               p == board[combo[1]],
               p == board[combo[2]] {
                winner = p
                return
            }
        }
    }

    func isBoardFull() -> Bool {
        return !board.contains(where: { $0 == nil })
    }
}
