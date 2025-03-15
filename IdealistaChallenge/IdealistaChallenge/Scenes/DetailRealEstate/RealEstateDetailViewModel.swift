//
//  RealEstateDetailPresenter.swift
//  IdealistaChallenge
//

import Foundation

class RealEstateDetailViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published var realEstateDetail: RealEstateDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    
    private let interactor: RealEStateInteractor
    private weak var coordinator: Coordinator?
    
    // MARK: - Initialization
    
    init(interactor: RealEStateInteractor, coordinator: Coordinator) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func loadPropertyDetail() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            self.realEstateDetail = try await interactor.detailRealEstate()
            self.isLoading = false
            
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
