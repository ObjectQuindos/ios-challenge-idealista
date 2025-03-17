
import UIKit

class BaseViewController: UIViewController {
    
    private let loaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.isHidden = true
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    
    private var emptyStateView: EmptyStateView = {
        let emptyView = EmptyStateView.createDefaultEmptyState()
        emptyView.isHidden = true
        return emptyView
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLoader()
        setupEmptyView()
    }
    
    private func setupLoader() {
        
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loaderView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)
        ])
    }
    
    private func setupEmptyView() {
        
        view.addSubview(emptyStateView)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emptyStateView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func showLoader() {
        loaderView.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        loaderView.isHidden = true
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        view.isUserInteractionEnabled = true
    }
    
    func showEmptyStateView() {
        emptyStateView.isHidden = false
    }
    
    func hideEmptyStateView() {
        emptyStateView.isHidden = true
    }
    
    func showAlert(title: String, message: String, okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizationKeys.accept.localized, style: .default) { _ in
            okAction?()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func updateEmptyState(image: UIImage? = nil, title: String, subtitle: String? = nil) {
        emptyStateView.update(image: image, title: title, message: subtitle)
    }
}
