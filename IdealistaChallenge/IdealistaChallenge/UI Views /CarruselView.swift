//
//  CarruselView.swift
//  IdealistaChallenge
//
//  Created by David López on 17/3/25.
//

import SwiftUI

struct AsyncImageCarousel: View {
    
    let imageUrls: [String]
    @State private var currentPage = 0
    
    var body: some View {
        
        VStack {
            
            TabView(selection: $currentPage) {
                
                ForEach(0..<max(1, imageUrls.count), id: \.self) { index in
                    
                    if index < imageUrls.count {
                        
                        AsyncImage(url: URL(string: imageUrls[index])) { phase in
                            showStateView(phase: phase)
                        }
                        .clipped()
                        .tag(index)
                        
                    } else {
                        PlaceholderView(imageName: "photo", text: "Imagen no disponible")
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 250)
            
            // Page Indicator
            if imageUrls.count > 1 {
                
                Text("\(currentPage + 1) / \(imageUrls.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, -5)
            }
        }
    }
    
    @ViewBuilder
    func showStateView(phase: AsyncImagePhase) -> some View {
        
        switch phase {
            
        case .empty:
            LoadingPlaceholderView()
            
        case .success(let image):
            image.resizable().scaledToFill()
            
        case .failure:
            PlaceholderView(imageName: "exclamationmark.triangle", text: "Error al cargar la imagen")
            
        @unknown default:
            LoadingPlaceholderView()
        }
    }
}

private struct LoadingPlaceholderView: View {
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.2)
            ProgressView()
        }
    }
}

private struct PlaceholderView: View {
    
    private let imageName: String
    private let text: String
    
    init(imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
    }
    
    var body: some View {
        
        ZStack {
            
            Color.gray.opacity(0.2)
            
            VStack {
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                Text(text)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
