//
//  GameBoardView.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

struct GameBoardView<VM: GameViewModelProtocol>: View {
    @ObservedObject var vm: VM
    let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        GeometryReader { geo in
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<9, id: \.self) { idx in
                    Button {
                        vm.makeMove(at: idx)
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(uiColor: .secondarySystemBackground))
                                .frame(height: geo.size.width / 3 - 12)
                            Text(vm.model.board[idx]?.rawValue ?? "")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    }
                    .disabled(vm.model.board[idx] != nil || vm.model.winner != nil)
                    .buttonStyle(.plain)
                }
            }
            .frame(width: geo.size.width)
        }
    }
}


