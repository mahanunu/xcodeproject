//
//  GameListView.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

struct GameListView: View {
    var body: some View {
        List {
            NavigationLink("Nouvelle partie vs IA") {
                GameView(vm: GameViewModel())
            }
            NavigationLink("Mode test (mock)") {
                GameView(vm: MockGameViewModel())
            }
        }
        .navigationTitle("TicTacToe")
    }
}

#Preview {
    GameListView()
}
