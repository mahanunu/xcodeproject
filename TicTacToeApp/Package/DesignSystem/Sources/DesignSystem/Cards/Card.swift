//
//  GameCardView.swift
//  DesignSystem
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

public final class CardViewModel: ObservableObject {
    @Published public var isSelected: Bool = false
    public init(isSelected: Bool = false) { self.isSelected = isSelected }
}

public struct Card<Content: View>: View {
    @ObservedObject var vm: CardViewModel
    let content: () -> Content

    public init(vm: CardViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.vm = vm
        self.content = content
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(vm.isSelected ? .blue : .gray, lineWidth: vm.isSelected ? 3 : 1)
                )
            content()
                .padding()
        }
    }
}

