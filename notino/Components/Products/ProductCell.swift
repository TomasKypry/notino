//
//  ProductCell.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.kf.indicatorType = .activity
        return view
    }()

    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()

    private let ratingView = RatingView()

    private lazy var cartButton = CartBuyButton { [weak self] in
        print("cart")
    }

    private lazy var favoriteButton = HeartButton { [weak self] active in
        self?.onFavoriteTap?(active)
    }

    var onFavoriteTap: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
        favoriteButton.setState(active: false)
    }

    func setup(with product: Product, isFavorite: Bool) {
        imageView.kf.setImage(with: imageDownloadUrl(for: product))
        brandLabel.text = product.brand.name
        nameLabel.text = product.name
        descriptionLabel.text = product.annotation
        priceLabel.text = price(for: product)
        ratingView.setupContent(maxRate: product.reviewSummary.score, rate: Int(product.reviewSummary.averageRating))
        favoriteButton.setState(active: isFavorite)
    }

    private func imageDownloadUrl(for product: Product) -> URL? {
        return URL(string: Constants.imagePrefixUrl + product.imageUrl)
    }

    private func price(for product: Product) -> String? {
        let currencySymbol: String

        switch product.price.currency {
        case .czk:
            currencySymbol = "Kč"
        }

        let formatter = NumberFormatter()
        formatter.currencySymbol = currencySymbol
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        return formatter.string(from: product.price.value as NSNumber)
    }

    private func setupLayout() {
        let stack = VStack(alignment: .center) {[
            imageView,
            VSpacer(10),
            brandLabel,
            VSpacer(5),
            nameLabel,
            VSpacer(5),
            descriptionLabel,
            VSpacer(5),
            ratingView,
            VSpacer(5),
            priceLabel,
            VSpacer(20),
            cartButton
        ]}
        contentView.addSubview(stack)
        stack.pinSidesToContainer(padding: 8)

        contentView.addSubview(favoriteButton)
        favoriteButton.pinTopToContainer(padding: 2)
        favoriteButton.pinRightToContainer(padding: 2)
    }
}
