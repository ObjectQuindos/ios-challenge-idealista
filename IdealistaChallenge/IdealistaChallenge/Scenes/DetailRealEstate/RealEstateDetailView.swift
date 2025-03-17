//
//  RealEstateDetailViewController.swift
//  IdealistaChallenge
//

import SwiftUI
import MapKit

struct RealEstateDetailView: View {
    
    @ObservedObject var viewModel: RealEstateDetailViewModel
    
    init(viewModel: RealEstateDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            
            RealEstateContentView(viewModel: viewModel).contentState(viewModel.contentState)
        }
        .task {
            if viewModel.realEstateDetail == nil {
                await viewModel.loadPropertyDetail()
            }
        }
    }
}

private struct RealEstateContentView: View {
    
    @ObservedObject var viewModel: RealEstateDetailViewModel
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            if let details = viewModel.realEstateDetail {
                let imageUrls = details.multimedia.images.map { $0.url }
                
                AsyncImageCarousel(imageUrls: imageUrls)
                    .padding(.top, 16)
            }
            
            if let details = viewModel.realEstateDetail {
                OverviewCard(title: LocalizationKeys.description.localized, description: details.propertyComment)
            }
            
            if let details = viewModel.realEstateDetail {
                FeaturesCard(realEstate: details)
            }
            
            if let details = viewModel.realEstateDetail {
                ExtrasCard(extras: details.getExtras())
            }
            
            if let details = viewModel.realEstateDetail {
                MapCard(latitude: details.ubication.latitude, longitude: details.ubication.longitude, title: details.getPropertyTypeText())
            }
        }
        .padding(.top, 16)
    }
}

private struct OverviewCard: View {
    
    let title: String
    let description: String
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        
        CardContainerView(backgroundColor: .primarySoftColor) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.darkTextColor)
                
                Text(description)
                    .foregroundColor(.mediumTextColor)
                    .lineLimit(isExpanded ? nil : 4)
                    .truncationMode(.tail)
                
                Button(action: {
                    
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? LocalizationKeys.see_less.localized : LocalizationKeys.see_more.localized)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondaryColor)
                }
                .padding(.top, 5)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        }
    }
}

private struct FeaturesCard: View {
    
    let realEstate: RealEstateDetail
    
    var body: some View {
        
        CardContainerView(backgroundColor: .primarySoftColor) {
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text(LocalizationKeys.characteristics.localized)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack(spacing: 20) {
                    
                    FeatureItem(
                        icon: "square",
                        value: realEstate.formatSize()
                    )
                    
                    FeatureItem(
                        icon: "bed.double",
                        value: realEstate.formatRooms()
                    )
                    
                    FeatureItem(
                        icon: "shower",
                        value: realEstate.formatBathrooms()
                    )
                }
                
                HStack {
                    Text(LocalizationKeys.type.localized + ":")
                        .fontWeight(.semibold)
                    Text(realEstate.getPropertyTypeText())
                }
                
                HStack {
                    Text(LocalizationKeys.floor.localized + ":")
                        .fontWeight(.semibold)
                    Text(realEstate.getFloorText())
                }
                
                if realEstate.moreCharacteristics.communityCosts > 0 {
                    
                    HStack {
                        Text(LocalizationKeys.community_expenses.localized + ":")
                            .fontWeight(.semibold)
                        Text(realEstate.getFormattedCommunityFees())
                    }
                }
            }
        }
    }
}

private struct FeatureItem: View {
    
    let icon: String
    let value: String
    
    var body: some View {
        
        VStack {
            
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.tertiaryColor)
            
            Text(value)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ExtrasCard: View {
    
    let extras: [String]
    
    var body: some View {
        
        CardContainerView(backgroundColor: .primarySoftColor) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(LocalizationKeys.extras.localized)
                    .font(.title2)
                    .fontWeight(.bold)
                
                ForEach(extras, id: \.self) { extra in
                    
                    HStack(spacing: 10) {
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.tertiaryColor)
                        
                        Text(extra)
                            .font(.body)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct MapCard: View {
    
    let latitude: Double
    let longitude: Double
    let title: String
    
    var body: some View {
        
        CardContainerView(backgroundColor: .primarySoftColor) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(LocalizationKeys.location.localized)
                    .font(.title2)
                    .fontWeight(.bold)
                
                MapView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: title)
                    .frame(height: 400)
                    .cornerRadius(12)
            }
        }
    }
}

/*#Preview {
    let coordinator = ListCoordinator(navigationController: BaseNavigationController(), dicontainer: AppDependencyContainer())
    RealEstateDetailFactory().makeModule(coordinator: coordinator, imageManager: ImageManager())
}*/








// MARK: - Preview
/*struct RealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        RealEstateView(viewModel: RealEstateDetailViewModel(
            interactor: MockRealEstateInteractor(),
            coordinator: MockCoordinator()
        ))
    }
}

// MARK: - Mock classes for Preview
class MockRealEstateInteractor: RealEStateInteractor {
    func detailRealEstate() async throws -> RealEstateDetail {
        // Return mock data
        return RealEstateDetail(
            adid: 1234,
            price: 250000,
            priceInfo: PriceInfoDetail(amount: 250000, currencySuffix: "€"),
            operation: "sale",
            propertyType: "homes",
            extendedPropertyType: "flat",
            homeType: "flat",
            state: "good",
            multimedia: Multimedia(),
            propertyComment: "Fantástico piso en el centro de la ciudad. Ideal para familias. Muy luminoso y en perfecto estado de conservación. Cerca de todos los servicios.",
            ubication: Ubication(latitude: 40.416775, longitude: -3.703790),
            country: "España",
            moreCharacteristics: MoreCharacteristics(
                communityCosts: 85,
                roomNumber: 3,
                bathNumber: 2,
                exterior: true,
                housingFurnitures: "none",
                agencyIsABank: false,
                energyCertificationType: "B",
                flatLocation: "exterior",
                modificationDate: Date().timeIntervalSince1970,
                constructedArea: 95,
                lift: true,
                boxroom: true,
                isDuplex: false,
                floor: "3",
                status: "good"
            ),
            energyCertification: EnergyCertification(
                title: "Certificación Energética",
                energyConsumption: EnergyInfo(type: "B"),
                emissions: EnergyInfo(type: "C")
            )
        )
    }
}*/
