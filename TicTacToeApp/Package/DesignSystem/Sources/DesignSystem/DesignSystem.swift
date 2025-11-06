// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct DesignSystem {
    public static let cornerRadius: CGFloat = 16
    public static let gradient = LinearGradient(
        colors: [.purple, .blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
