//
//  RealEstateDetailPresenter.swift
//  IdealistaChallenge
//

import Foundation

class RealEstateDetailViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    @Published var realEstateDetail: RealEstateDetail?
    
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
        error = nil
        
        do {
            self.realEstateDetail = try await interactor.detailRealEstate()
            self.isLoading = false
            isEmptySourceData = realEstateDetail == nil
            
        } catch {
            self.error = error
            self.isLoading = false
        }
    }
}

extension RealEstateDetailViewModel: ContentStateViewModel {
    
    var contentState: ContentState {
        determineContentState(isLoading: isLoading, error: error, isEmpty: isEmptySourceData, retryAction: nil, retryAsyncAction: { })
    }
}
