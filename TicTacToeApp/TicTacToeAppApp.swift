//
//  TicTacToeAppApp.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

@main
struct TicTacToeAppApp: App {
    var body: some Scene {
            WindowGroup {
                NavigationStack {
                    GameView(vm: GameViewModel())
                }
            }
    }
}
