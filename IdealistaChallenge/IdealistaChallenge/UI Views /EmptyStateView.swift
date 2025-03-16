//
//  EmptyStateView.swift
//  IdealistaChallenge
//

//
//  EmptyStateView.swift
//  IdealistaChallenge
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    init(image: UIImage?, title: String, message: String? = nil) {
        super.init(frame: .zero)
        setupView(image: image, title: title, message: message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupView(image: UIImage?, title: String, message: String?) {
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = image
        titleLabel.text = title
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        if let message = message {
            messageLabel.text = message
            stackView.addArrangedSubview(messageLabel)
            
        } else {
            messageLabel.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // MARK: - Public Methods
    
    func update(image: UIImage?, title: String, message: String? = nil) {
        
        imageView.image = image
        titleLabel.text = title
        
        if let message = message {
            messageLabel.isHidden = false
            messageLabel.text = message
            
        } else {
            messageLabel.isHidden = true
        }
    }
}

extension EmptyStateView {
    
    static func createDefaultEmptyState() -> EmptyStateView {
        let title = "Sin resultados"
        return EmptyStateView(image: UIImage(systemName: "magnifyingglass"), title: title)
    }
}
