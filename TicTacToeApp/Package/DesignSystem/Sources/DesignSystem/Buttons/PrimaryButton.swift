//
//  Untitled.swift
//  DesignSystem
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

public struct PrimaryButtonViewModel {
    public var title: String
    public var action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

public struct PrimaryButton: View {
    @State private var isPressed = false
    public var vm: PrimaryButtonViewModel

    public init(vm: PrimaryButtonViewModel) {
        self.vm = vm
    }

    public var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
                vm.action()
            }
        }) {
            Text(vm.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.pink, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(14)
                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .padding(.horizontal, 20)
        }
    }
}


