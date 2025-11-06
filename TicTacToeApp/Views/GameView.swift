//
//  Untitled.swift
//  TicTacToeApp
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI
import PhotosUI
import DesignSystem

struct GameView<VM: GameViewModelProtocol>: View {
    @StateObject var vm: GameViewModel
    private var viewModel: VM { vm as! VM }
    @State private var selectedItemX: PhotosPickerItem?
    @State private var selectedItemO: PhotosPickerItem?
    @State private var showWinAnimation = false
    @State private var winner: Player? = nil

    var body: some View {
        ZStack {
            // 🌈 Fond dégradé
            LinearGradient(
                colors: [.purple.opacity(0.85), .blue.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                if !vm.gameStarted {
                    Text("Personnalise tes joueurs 🧍‍♂️🧍‍♀️")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()

                    // 🧍‍♂️ Choix des images pour X et O
                    HStack(spacing: 40) {
                        VStack {
                            Text("Joueur X").foregroundColor(.white)
                        }

                        VStack {
                            PhotosPicker(selection: $selectedItemX, matching: .images) {
                                if let image = vm.playerXImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(.white, lineWidth: 3))
                                } else {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                        .frame(width: 80, height: 80)
                                        .overlay(Text("X").font(.title).bold().foregroundColor(.white))
                                }
                            }
                            .onChange(of: selectedItemX) { newItem in
                                guard let newItem else { return }
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        vm.playerXImage = uiImage
                                    }
                                }
                            }


                            Text("Joueur O").foregroundColor(.white)
                        }
                    }

                    Divider().background(Color.white.opacity(0.5))

                    Text("Choisis ton symbole pour commencer 🎮")
                        .font(.title3)
                        .foregroundColor(.white)

                    HStack(spacing: 20) {
                        PrimaryButton(vm: PrimaryButtonViewModel(title: "Jouer avec X") {
                            vm.chooseStartingPlayer(.x)
                        })
                        PrimaryButton(vm: PrimaryButtonViewModel(title: "Jouer avec O") {
                            vm.chooseStartingPlayer(.o)
                        })
                    }
                } else {
                    // Plateau du jeu
                    VStack(spacing: 20) {
                        Text("Tour du joueur : \(vm.model.currentPlayer.rawValue)")
                            .font(.headline)
                            .foregroundColor(.white)

                        GameBoardView(vm: vm)

                        PrimaryButton(vm: PrimaryButtonViewModel(title: "Recommencer") {
                            vm.restartGame()
                        })

                        Button("Changer de symbole") {
                            vm.restartGame()
                        }
                        .font(.footnote)
                        .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
    }
}

