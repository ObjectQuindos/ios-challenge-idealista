//
//  RealEstateCell.swift
//  IdealistaChallenge
//

import UIKit

protocol RealEstateTableViewCellInterface {
    func configureTexts(realEstate: RealEstate)
    func configureFavoriteButton(isFavorite: Bool)
    func setFavoriteAction(_ action: @escaping () -> Void)
    func setImage(_ image: UIImage?)
}

class RealEstateTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = Identifiers.realEstateTableViewCellIdentifier
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackgroundColor
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let realEstateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
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
    
    private let propertyTypeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let districtMunicipalityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .mediumTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .darkTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roomsSizeFloorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .mediumTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let featuresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .mediumTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let savedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .mediumTextColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var favoriteAction: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        realEstateImageView.image = nil
        operationLabel.text = nil
        propertyTypeAddressLabel.text = nil
        districtMunicipalityLabel.text = nil
        priceLabel.text = nil
        roomsSizeFloorLabel.text = nil
        featuresLabel.text = nil
        savedDateLabel.text = nil
    }
    
    // MARK: - Setup
    
    private var featuresBottomConstraint: NSLayoutConstraint!
    private var roomsBottomConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(realEstateImageView)
        containerView.addSubview(operationLabel)
        containerView.addSubview(propertyTypeAddressLabel)
        containerView.addSubview(districtMunicipalityLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(roomsSizeFloorLabel)
        containerView.addSubview(featuresLabel)
        containerView.addSubview(savedDateLabel)
        containerView.addSubview(favoriteButton)
        
        // Active or no active as content
        featuresBottomConstraint = featuresLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        roomsBottomConstraint = roomsSizeFloorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            realEstateImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            realEstateImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            realEstateImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            realEstateImageView.heightAnchor.constraint(equalToConstant: 180),
            
            operationLabel.topAnchor.constraint(equalTo: realEstateImageView.topAnchor, constant: 8),
            operationLabel.leadingAnchor.constraint(equalTo: realEstateImageView.leadingAnchor, constant: 8),
            operationLabel.heightAnchor.constraint(equalToConstant: 24),
            
            savedDateLabel.topAnchor.constraint(equalTo: realEstateImageView.bottomAnchor, constant: 4),
            savedDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            savedDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            propertyTypeAddressLabel.topAnchor.constraint(equalTo: savedDateLabel.bottomAnchor, constant: 12),
            propertyTypeAddressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            propertyTypeAddressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            districtMunicipalityLabel.topAnchor.constraint(equalTo: propertyTypeAddressLabel.bottomAnchor, constant: 6),
            districtMunicipalityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            districtMunicipalityLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            priceLabel.topAnchor.constraint(equalTo: districtMunicipalityLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            roomsSizeFloorLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            roomsSizeFloorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            roomsSizeFloorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            featuresLabel.topAnchor.constraint(equalTo: roomsSizeFloorLabel.bottomAnchor, constant: 8),
            featuresLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            featuresLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            // Por defecto activamos featuresBottomConstraint (se ajustará en configureTexts)
            featuresBottomConstraint
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: realEstateImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: realEstateImageView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        favoriteAction?()
    }
}

extension RealEstateTableViewCell: RealEstateTableViewCellInterface {
    
    func configureTexts(realEstate: RealEstate) {
        
        operationLabel.text = realEstate.getOperationLabel()
        operationLabel.backgroundColor = realEstate.getOperationColor()
        
        savedDateLabel.text = realEstate.formatSaveDate()
        propertyTypeAddressLabel.text = realEstate.fullAddress()
        districtMunicipalityLabel.text = realEstate.getDistrict()
        priceLabel.text = realEstate.formatPrice()
        roomsSizeFloorLabel.text = realEstate.flatInfo()
        
        featuresLabel.text = "Features"
        
        configureFavoriteButton(isFavorite: realEstate.isFavorite ?? false)
    }
    
    func configureFavoriteButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setFavoriteAction(_ action: @escaping () -> Void) {
        self.favoriteAction = action
    }
    
    func setImage(_ image: UIImage?) {
        realEstateImageView.image = image ?? UIImage(systemName: "photo")
    }
}
