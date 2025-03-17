//
//  FavoritesViewController.swift
//  IdealistaChallenge
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let presenter: FavoritesPresenter
    private let adapter: RealEstateAdapter
    
    // MARK: - Inits
    
    init(presenter: FavoritesPresenter) {
        self.presenter = presenter
        self.adapter = RealEstateAdapter()
        
        super.init(nibName: nil, bundle: nil)
        
        adapter.delegate = presenter
        adapter.configure(tableView: self.tableView)
        self.presenter.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateEmptyState(image: UIImage(systemName: "heart.slash"), title: "No hay favoritos", subtitle: "Busca propiedades y añádelas como favoritas para más fácil acceso.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadFavorites()
    }
    
    private func setupUI() {
        
        title = LocalizationKeys.favorites.localized
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - FavoritesViewProtocol

extension FavoritesViewController: FavoritesViewProtocol {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.showLoader()
            self.tableView.isHidden = true
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.updateEmptyState()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateEmptyState()
        }
    }
    
    private func updateEmptyState() {
        let isEmpty = presenter.numberOfRows() == 0
        tableView.isHidden = isEmpty
        isEmpty == true ? showEmptyStateView() : hideEmptyStateView()
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}
