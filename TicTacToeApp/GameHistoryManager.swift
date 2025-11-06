// GameHistoryManager.swift


import Foundation

final class HistoryManager: ObservableObject {
    static let shared = HistoryManager()
    
    @Published var games: [GameHistoryEntry] = []
    
    private init() {
        loadHistory()
    }
    
    // HistoryManager.swift
    func recordSession(playerXName: String, playerOName: String, scoreX: Int, scoreO: Int) {
        let entry = GameHistoryEntry(
            date: Date(),
            finalScoreX: scoreX,
            finalScoreO: scoreO,
            playerXName: playerXName,
            playerOName: playerOName
        )
        games.append(entry)
        saveHistory()
    }
    func resetHistory() {
        games.removeAll()
        saveHistory()
    }
    
    private func saveHistory() {
        if let data = try? JSONEncoder().encode(games) {
            UserDefaults.standard.set(data, forKey: "gameHistory")
        }
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: "gameHistory"),
           let decoded = try? JSONDecoder().decode([GameHistoryEntry].self, from: data) {
            games = decoded
        }
    }
}


