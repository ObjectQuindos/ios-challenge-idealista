//
//  RealEstateCell.swift
//  IdealistaChallenge
//

import UIKit

protocol RealEstateTableViewCellInterface {
    func configureTexts(realEstate: RealEstate)
}

class RealEstateTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "RealEstateTableViewCell"
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let propertyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let operationLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roomsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        propertyImageView.image = nil
        operationLabel.text = nil
        priceLabel.text = nil
        addressLabel.text = nil
        sizeLabel.text = nil
        roomsLabel.text = nil
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(propertyImageView)
        containerView.addSubview(operationLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(sizeLabel)
        containerView.addSubview(roomsLabel)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            propertyImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            propertyImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            propertyImageView.heightAnchor.constraint(equalToConstant: 120),
            propertyImageView.widthAnchor.constraint(equalToConstant: 160),
            
            operationLabel.topAnchor.constraint(equalTo: propertyImageView.topAnchor, constant: 8),
            operationLabel.leadingAnchor.constraint(equalTo: propertyImageView.leadingAnchor, constant: 8),
            operationLabel.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            sizeLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            sizeLabel.leadingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: 16),
            sizeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            roomsLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            roomsLabel.leadingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: 16),
            roomsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
        ])
    }
}

extension RealEstateTableViewCell: RealEstateTableViewCellInterface {
    
    func configureTexts(realEstate: RealEstate) {
        
        operationLabel.text = realEstate.getOperationLabel()
        operationLabel.backgroundColor = getOperationColor(realEstate)
        priceLabel.text = realEstate.formatPrice()
        addressLabel.text = realEstate.getAddress()
        sizeLabel.text = realEstate.formatSize()
        roomsLabel.text = realEstate.formatRoomsAndBathrooms()
    }
    
    private func getOperationColor(_ realEstate: RealEstate) -> UIColor {
        
        switch realEstate.operation {
            
        case "sale":
            return UIColor(red: 0.2, green: 0.6, blue: 0.9, alpha: 1.0) // Blue
            
        case "rent":
            return UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0) // Green
            
        default:
            return .gray
        }
    }
}

// MARK: - Padded Label

class PaddedLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
