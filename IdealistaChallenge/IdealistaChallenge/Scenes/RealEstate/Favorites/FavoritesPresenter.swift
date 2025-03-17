//
//  FavoritesPresenter.swift
//  IdealistaChallenge
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showError(_ error: Error)
}

class FavoritesPresenter: RealEstateBasePresenter {
    
    // MARK: - Properties
    
    private var favoritesDataSource: [RealEstate] = []
    private let interactor: FavoritesInteractor
    
    weak var delegate: FavoritesViewProtocol?
    private weak var coordinator: Coordinator?
    
    // MARK: - Init
    
    init(interactor: FavoritesInteractor, coordinator: Coordinator, imageManager: ImageManaging) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        super.init(imageManager: imageManager)
    }
    
    // MARK: - Public API (functions)
    
    func loadFavorites() {
        delegate?.showLoading()
        
        do {
            let response = try interactor.listFavorites()
            self.favoritesDataSource = response
            
            imageManager.preloadImages(for: favoritesDataSource)
            
            delegate?.reloadData()
            delegate?.hideLoading()
            
        } catch {
            delegate?.showError(error)
            delegate?.hideLoading()
        }
    }
    
    func removeFavorite(at index: Int) {
        
        do {
            let favorite = favoritesDataSource[index]
            try interactor.removeFavorite(realEstate: favorite)
            favoritesDataSource.remove(at: index)
            
            delegate?.reloadData()
            
        } catch {
            delegate?.showError(error)
        }
    }
    
    // MARK: - RealEstateAdapterDelegate
    
    override func numberOfRows() -> Int {
        favoritesDataSource.count
    }
    
    override func item(at index: Int) -> RealEstate {
        favoritesDataSource[index]
    }
    
    override func didSelectedItem(at index: Int) {
        //let item = favoritesDataSource[index]
        coordinator?.navigate(to: .propertyDetailSwiftUI)
    }
    
    override func configureFavoriteAction(for item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        
        cell.setFavoriteAction { [weak self] in
            guard let self = self,
                  let index = self.findIndex(for: item.propertyCode, in: self.favoritesDataSource) else {
                return
            }
            
            self.removeFavorite(at: index)
        }
    }
}
