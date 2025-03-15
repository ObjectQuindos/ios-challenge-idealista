//
//  ViewController.swift
//  IdealistaChallenge
//

import UIKit

class RealEstateViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .darkGray
        return refreshControl
    }()
    
    private let presenter: RealEstateListPresenter
    private let adapter: RealEstateAdapter
    
    // MARK: - Inits
    
    init(presenter: RealEstateListPresenter) {
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
        configureRefreshControl()
        
        Task {
            await presenter.loadRealEstates()
        }
    }
    
    private func setupUI() {
        
        title = "Propiedades"
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        
        Task {
            await presenter.loadRealEstates()
        }
    }
}

// MARK: - PropertyListViewProtocol

extension RealEstateViewController: RealEstateListViewProtocol {
    
    func showLoading() {
        
        DispatchQueue.main.async {
            
            if !self.refreshControl.isRefreshing {
                self.showLoader()
                self.tableView.isHidden = true
            }
        }
    }
    
    func hideLoading() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideLoader()
            self.tableView.isHidden = false
            self.endRefreshControl()
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        
        DispatchQueue.main.async {
            self.showAlert(title: "Error", message: error.localizedDescription)
            self.endRefreshControl()
        }
    }
    
    private func endRefreshControl() {
        
        if self.refreshControl.isRefreshing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refreshControl.endRefreshing()
            }
        }
    }
}
