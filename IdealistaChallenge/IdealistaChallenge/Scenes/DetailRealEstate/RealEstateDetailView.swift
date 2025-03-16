//
//  RealEstateDetailViewController.swift
//  IdealistaChallenge
//

import SwiftUI

struct RealEstateDetailView: View {
    
    @ObservedObject var viewModel: RealEstateDetailViewModel
    
    init(viewModel: RealEstateDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                if viewModel.isLoading {
                    loadingView
                    
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                    
                } else if let property = viewModel.realEstateDetail {
                    propertyDetailContent(property)
                    
                } else {
                    EmptyView()
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .task {
            if viewModel.realEstateDetail == nil {
                await viewModel.loadPropertyDetail()
            }
        }
    }
    
    // MARK: - UI Components
    
    private var loadingView: some View {
        
        VStack {
            
            Spacer()
            
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            
            Text("Cargando detalles...")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 300)
    }
    
    private func errorView(message: String) -> some View {
        
        VStack(spacing: 16) {
            
            Spacer()
            
            /*Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)*/
            
            Text("No se pudo cargar la información")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Reintentar") {
                
                Task {
                    await viewModel.loadPropertyDetail()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding()
    }
    
    private func propertyDetailContent(_ property: RealEstateDetail) -> some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            //imageGallery(property.multimedia.images)
            
            VStack(alignment: .leading, spacing: 12) {
                // Header info
                propertyHeader(property)
                
                Divider()
                
                // Main info
                propertyMainInfo(property)
                
                Divider()
                
                // Features
                propertyFeatures(property)
                
                Divider()
                
                // Energy certification
                energyCertification(property.energyCertification)
                
                Divider()
                
                // Description
                propertyDescription(property.propertyComment)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5)
            .padding(.horizontal)
        }
    }
    
    /*private func imageGallery(_ images: [Multimedia.Image]) -> some View {
        
        TabView {
            
            ForEach(images) { image in
                
                AsyncImage(url: URL(string: image.url)) { phase in
                    
                    switch phase {
                        
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay(ProgressView())
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .font(.largeTitle)
                            )
                    @unknown default:
                        Rectangle().fill(Color.gray.opacity(0.2))
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    Text(image.localizedName)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(4)
                        .padding(8)
                }
            }
        }
        .frame(height: 300)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    */
    private func propertyHeader(_ property: RealEstateDetail) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                
                Text(property.getOperationLabel())
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(getOperationColor(property: property))
                    .cornerRadius(8)
                
                Spacer()
                
                Text(property.formatPrice())
                    .font(.title2)
                    .bold()
            }
            
            Text(property.getPropertyTypeText())
                .font(.title3)
                .bold()
        }
    }
    
    func getOperationColor(property: RealEstateDetail) -> Color {
        
        switch property.operation {
        case "sale":
            return Color(red: 0.2, green: 0.6, blue: 0.9) // Blue
        case "rent":
            return Color(red: 0.2, green: 0.7, blue: 0.3) // Green
        default:
            return Color.gray
        }
    }
    
    private func propertyMainInfo(_ property: RealEstateDetail) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Características principales")
                .font(.headline)
            
            HStack(spacing: 20) {
                
                VStack(alignment: .leading) {
                    
                    Label(property.formatSize(), systemImage: "squareshape")
                        .padding(.bottom, 4)
                    
                    Label(property.formatRoomsAndBathrooms(), systemImage: "bed.double")
                        .padding(.bottom, 4)
                    
                    Label(property.getFloorText(), systemImage: "building")
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    
                    Label("Gastos comunitarios:", systemImage: "eurosign.circle")
                        .font(.subheadline)
                    
                    Text(property.getFormattedCommunityFees())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func propertyFeatures(_ property: RealEstateDetail) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Extras")
                .font(.headline)
            
            let extras = property.getExtras()
            
            FlowLayout(spacing: 8) {
                ForEach(extras, id: \.self) { extra in
                    Text(extra)
                        .font(.footnote)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                }
            }
        }
    }
    
    private func energyCertification(_ certification: EnergyCertification) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text(certification.title)
                .font(.headline)
            
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Consumo")
                        .font(.subheadline)
                    
                    Text(certification.energyConsumption.type.uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(getEnergyCertificationColor(type: certification.energyConsumption.type))
                        .cornerRadius(18)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Emisiones")
                        .font(.subheadline)
                    
                    Text(certification.emissions.type.uppercased())
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(getEnergyCertificationColor(type: certification.emissions.type))
                        .cornerRadius(18)
                }
            }
        }
    }
    
    private func propertyDescription(_ description: String) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Descripción")
                .font(.headline)
            
            Text(description)
                .font(.body)
                .lineSpacing(4)
        }
    }
    
    func getEnergyCertificationColor(type: String) -> Color {
        switch type.lowercased() {
        case "a":
            return Color.green
        case "b":
            return Color(red: 0.3, green: 0.8, blue: 0.3)
        case "c":
            return Color(red: 0.5, green: 0.8, blue: 0.3)
        case "d":
            return Color.yellow
        case "e":
            return Color.orange
        case "f":
            return Color(red: 0.9, green: 0.5, blue: 0.3)
        case "g":
            return Color.red
        default:
            return Color.gray
        }
    }
}

// MARK: - FlowLayout para mostrar tags de características

struct FlowLayout: Layout {
    
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for size in sizes {
            
            if rowWidth + size.width > proposal.width ?? .infinity {
                // Inicia una nueva fila
                width = max(width, rowWidth - spacing)
                height += rowHeight + spacing
                rowWidth = size.width + spacing
                rowHeight = size.height
                
            } else {
                // Continúa en la fila actual
                rowWidth += size.width + spacing
                rowHeight = max(rowHeight, size.height)
            }
        }
        
        // Añade la última fila
        width = max(width, rowWidth - spacing)
        height += rowHeight
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        var rowStartIndex = 0
        
        for (index, size) in sizes.enumerated() {
            if rowWidth + size.width > proposal.width ?? .infinity {
                // Coloca elementos de la fila anterior
                placeRowItems(
                    in: bounds,
                    from: rowStartIndex,
                    to: index,
                    y: rowWidth > 0 ? bounds.minY + rowHeight + spacing : bounds.minY,
                    sizes: sizes,
                    subviews: subviews
                )
                
                // Inicia una nueva fila
                rowStartIndex = index
                rowWidth = size.width + spacing
                rowHeight = size.height
            } else {
                // Continúa en la fila actual
                rowWidth += size.width + spacing
                rowHeight = max(rowHeight, size.height)
            }
        }
        
        // Coloca elementos de la última fila
        if rowStartIndex < subviews.count {
            placeRowItems(
                in: bounds,
                from: rowStartIndex,
                to: subviews.count,
                y: rowWidth > 0 ? bounds.minY + rowHeight + spacing : bounds.minY,
                sizes: sizes,
                subviews: subviews
            )
        }
    }
    
    private func placeRowItems(in bounds: CGRect, from startIndex: Int, to endIndex: Int, y: CGFloat, sizes: [CGSize], subviews: Subviews) {
        
        var x = bounds.minX
        
        for index in startIndex..<endIndex {
            let size = sizes[index]
            subviews[index].place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(size)
            )
            x += size.width + spacing
        }
    }
}
