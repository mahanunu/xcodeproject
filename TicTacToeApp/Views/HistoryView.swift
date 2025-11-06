//
//  HistoryView.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 06/11/2025.
//

// HistoryView.swift
import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyManager = HistoryManager.shared

    // Formatter statique pour éviter de le recréer à chaque view
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        List(historyManager.games.reversed(), id: \.id) { entry in
            VStack(alignment: .leading) {
                Text(Self.dateFormatter.string(from: entry.date))
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack {
                    Text(entry.playerXName)
                    Text("vs")
                    Text(entry.playerOName)
                }

                // ⚠️ MAIS ATTENTION : entry n'a PLUS de 'winner' !
                // Tu as changé GameHistoryEntry → il faut afficher les scores !
                Text("Score final : \(entry.finalScoreX) - \(entry.finalScoreO)")
                    .fontWeight(.bold)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Historique")
    }
}
