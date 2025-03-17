//
//  Untitled.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import SwiftUI

struct CardContainerView<Content: View>: View {
    
    private let backgroundColor: Color
    private let content: Content
    
    init(backgroundColor: Color = .white, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                content
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 16)
    }
}
