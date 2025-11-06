//
//  Untitled.swift
//  DesignSystem
//
//  Created by AGRÉ William on 05/11/2025.
//

import SwiftUI

public struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        if #available(macOS 10.15, *) {
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(6)
        } else {
            // Fallback on earlier versions
        }
    }
}
