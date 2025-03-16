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

class FavoritesPresenter {
    
    // MARK: - Properties
    
    private var favoritesDataSource: [RealEstate] = []
    private let interactor: FavoritesInteractor
    
    weak var delegate: FavoritesViewProtocol?
    private weak var coordinator: Coordinator?
    
    // MARK: - Init
    
    init(interactor: FavoritesInteractor, coordinator: Coordinator) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    // MARK: - Public API (functions)
    
    func loadFavorites() {
        delegate?.showLoading()
        
        do {
            let response = try interactor.listFavorites()
            self.favoritesDataSource = response
            
            delegate?.reloadData()
            delegate?.hideLoading()
            
        } catch {
            delegate?.showError(error)
            delegate?.hideLoading()
        }
    }
    
    func removeFavorite(at index: Int) async {
        
        do {
            let favorite = favoritesDataSource[index]
            try await interactor.removeFavorite(realEstate: favorite)
            favoritesDataSource.remove(at: index)
            
            delegate?.reloadData()
        } catch {
            delegate?.showError(error)
        }
    }
}

// MARK: - RealEstateAdapterDelegate

extension FavoritesPresenter: RealEstateAdapterDelegate {
    
    func numberOfRows() -> Int {
        favoritesDataSource.count
    }
    
    func item(at index: Int) -> RealEstate {
        favoritesDataSource[index]
    }
    
    func present(item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        cell.configureTexts(realEstate: item)
    }
    
    func didSelectedItem(at index: Int) {
        //let item = favoritesDataSource[index]
        coordinator?.navigate(to: .propertyDetailSwiftUI)
    }
}
