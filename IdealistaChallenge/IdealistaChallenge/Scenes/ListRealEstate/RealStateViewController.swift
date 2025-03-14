//
//  ViewController.swift
//  IdealistaChallenge
//

import UIKit

class RealEstateViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        
        Task {
            await presenter.loadRealEstates()
        }
    }
    
    private func setupUI() {
        
        title = "Propiedades"
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - PropertyListViewProtocol

extension RealEstateViewController: RealEstateListViewProtocol {
    
    func showLoading() {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.tableView.isHidden = true
        }
    }
    
    func hideLoading() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
