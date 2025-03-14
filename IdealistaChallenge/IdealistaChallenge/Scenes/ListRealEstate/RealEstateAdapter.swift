//
//  RealEstateAdapter.swift
//  IdealistaChallenge
//

import UIKit

protocol RealEstateAdapterDelegate: AnyObject {
    func numberOfRows() -> Int
    func item(at index: Int) -> RealEstate
    func present(item: RealEstate, in cell: RealEstateTableViewCellInterface)
    func didSelectedItem(at index: Int)
}

class RealEstateAdapter: NSObject {
    
    private weak var tableView: UITableView?
    weak var delegate: RealEstateAdapterDelegate?
    
    func configure(tableView: UITableView) {
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(RealEstateTableViewCell.self, forCellReuseIdentifier: RealEstateTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView
    }
}

// MARK: - UITableViewDataSource

extension RealEstateAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RealEstateTableViewCell.identifier, for: indexPath) as? RealEstateTableViewCell,
              let item = delegate?.item(at: indexPath.row)
                
        else {
            return UITableViewCell()
        }
        
        delegate?.present(item: item, in: cell)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RealEstateAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedItem(at: indexPath.row)
    }
}
