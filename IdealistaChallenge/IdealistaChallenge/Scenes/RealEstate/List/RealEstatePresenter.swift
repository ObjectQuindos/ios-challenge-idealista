//
//  RealEstatePresenter.swift
//  IdealistaChallenge
//

import UIKit

protocol RealEstateListViewProtocol: AnyObject {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showError(_ error: Error)
}

class RealEstateListPresenter: RealEstateBasePresenter {
    
    // MARK: - Properties
    
    private var realEstateDataSource: [RealEstate] = []
    private let interactor: RealEStateInteractor
    private let favoritesInteractor: FavoritesInteractor
    
    weak var delegate: RealEstateListViewProtocol?
    private weak var coordinator: Coordinator?
    
    // MARK: - Init
    
    init(interactor: RealEStateInteractor, favoritesInteractor: FavoritesInteractor, coordinator: Coordinator, imageManager: ImageManaging) {
        self.interactor = interactor
        self.favoritesInteractor = favoritesInteractor
        self.coordinator = coordinator
        
        super.init(imageManager: imageManager)
    }
    
    // MARK: - Public API (functions)
    
    func loadRealEstates() async {
        delegate?.showLoading()
        
        do {
            let response = try await interactor.listRealEState()
            await syncFavoritesStatus(response: response)
            
            imageManager.preloadImages(for: realEstateDataSource)
            
            delegate?.reloadData()
            delegate?.hideLoading()
            
        } catch {
            delegate?.showError(error)
            delegate?.hideLoading()
        }
    }
    
    @MainActor
    func syncFavoritesStatus(response: [RealEstate]? = nil) {
        let dataSource = response ?? realEstateDataSource
        self.realEstateDataSource = self.favoritesInteractor.syncFavoriteStatus(realEstates: dataSource)
        delegate?.reloadData()
    }
    
    func toggleFavorite(for realEstate: RealEstate, at index: Int) {
        
        let updatedRealEstate = favoritesInteractor.toogleFavorite(for: realEstate)
        
        if index < realEstateDataSource.count {
            realEstateDataSource[index] = updatedRealEstate
            delegate?.reloadData()
        }
    }
    
    // MARK: - RealEstateAdapterDelegate
    
    override func numberOfRows() -> Int {
        realEstateDataSource.count
    }
    
    override func item(at index: Int) -> RealEstate {
        realEstateDataSource[index]
    }
    
    override func configureFavoriteAction(for item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        
        cell.setFavoriteAction { [weak self] in
            guard let self = self,
                  let index = self.findIndex(for: item.propertyCode, in: self.realEstateDataSource) else {
                return
            }
            
            self.toggleFavorite(for: item, at: index)
        }
    }
    
    override func didSelectedItem(at index: Int) {
        //let item = realEstateDataSource[index]
        coordinator?.navigate(to: .propertyDetailSwiftUI)
    }
}
