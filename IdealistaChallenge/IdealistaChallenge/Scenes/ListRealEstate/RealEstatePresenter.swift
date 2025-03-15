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
    
    weak var delegate: RealEstateListViewProtocol?
    private weak var coordinator: Coordinator?
    
    // MARK: - Init
    
    init(interactor: RealEStateInteractor, coordinator: Coordinator) {
        self.interactor = interactor
        self.coordinator = coordinator
        print("RealEstateListPresenter")
    }
    
    deinit {
        print("deinit RealEstateListPresenter")
    }
    
    // MARK: - Public API (functions)
    
    func loadRealEstates() async {
        delegate?.showLoading()
        
        do {
            let response = try await interactor.listRealEState()
            self.realEstateDataSource = response
            
            delegate?.reloadData()
            delegate?.hideLoading()
            
        } catch {
            delegate?.showError(error)
            delegate?.hideLoading()
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
    }
    
    func didSelectedItem(at index: Int) {
        //let item = realEstateDataSource[index]
        coordinator?.navigate(to: .propertyDetailSwiftUI)
    }
}
