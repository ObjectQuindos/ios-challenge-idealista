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

class RealEstateListPresenter {
    
    // MARK: - Properties
    
    private var realEstateDataSource: [RealEstate] = []
    private let interactor: RealEStateInteractor
    private let favoritesInteractor: FavoritesInteractor
    
    weak var delegate: RealEstateListViewProtocol?
    private weak var coordinator: Coordinator?
    
    // MARK: - Init
    
    init(interactor: RealEStateInteractor, favoritesInteractor: FavoritesInteractor, coordinator: Coordinator) {
        self.interactor = interactor
        self.favoritesInteractor = favoritesInteractor
        self.coordinator = coordinator
    }
    
    // MARK: - Public API (functions)
    
    func loadRealEstates() async {
        delegate?.showLoading()
        
        do {
            let response = try await interactor.listRealEState()
            //self.realEstateDataSource = response
            
            DispatchQueue.main.async {
                
                self.realEstateDataSource = response.map { realEstate in
                    
                    let isFavorite = self.favoritesInteractor.isRealEstateFavorite(propertyCode: realEstate.propertyCode)
                    
                    // Si la propiedad ya está marcada como favorita en nuestro modelo local
                    // pero no en CoreData, o viceversa, actualizar el modelo
                    if isFavorite != realEstate.isFavorite {
                        return RealEstate(
                            propertyCode: realEstate.propertyCode,
                            thumbnail: realEstate.thumbnail,
                            floor: realEstate.floor,
                            price: realEstate.price,
                            priceInfo: realEstate.priceInfo,
                            propertyType: realEstate.propertyType,
                            operation: realEstate.operation,
                            size: realEstate.size,
                            exterior: realEstate.exterior,
                            rooms: realEstate.rooms,
                            bathrooms: realEstate.bathrooms,
                            address: realEstate.address,
                            province: realEstate.province,
                            municipality: realEstate.municipality,
                            district: realEstate.district,
                            country: realEstate.country,
                            neighborhood: realEstate.neighborhood,
                            latitude: realEstate.latitude,
                            longitude: realEstate.longitude,
                            description: realEstate.description,
                            multimedia: realEstate.multimedia,
                            features: realEstate.features,
                            parkingSpace: realEstate.parkingSpace,
                            isFavorite: isFavorite
                        )
                    }
                    
                    return realEstate
                }
            }
            
            delegate?.reloadData()
            delegate?.hideLoading()
            
        } catch {
            delegate?.showError(error)
            delegate?.hideLoading()
        }
    }
    
    func toggleFavorite(for realEstate: RealEstate, at index: Int) {
        
        let updatedRealEstate = favoritesInteractor.toogleFavorite(for: realEstate)
        
        if index < realEstateDataSource.count {
            realEstateDataSource[index] = updatedRealEstate
            delegate?.reloadData()
        }
    }
}

// MARK: - RealEstateAdapterDelegate

extension RealEstateListPresenter: RealEstateAdapterDelegate {
    
    func numberOfRows() -> Int {
        realEstateDataSource.count
    }
    
    func item(at index: Int) -> RealEstate {
        realEstateDataSource[index]
    }
    
    func present(item: RealEstate, in cell: RealEstateTableViewCellInterface) {
        cell.configureTexts(realEstate: item)
        
        cell.setFavoriteAction { [weak self] in
            
            guard let self = self, let index = self.realEstateDataSource.firstIndex(where: { $0.propertyCode == item.propertyCode }) else { return }
            
            self.toggleFavorite(for: item, at: index)
        }
    }
    
    func didSelectedItem(at index: Int) {
        //let item = realEstateDataSource[index]
        coordinator?.navigate(to: .propertyDetailSwiftUI)
    }
}
