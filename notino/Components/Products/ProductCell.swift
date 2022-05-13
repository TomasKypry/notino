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
        self?.viewModel?.onFavoriteChange?(active)
    }

    private var viewModel: ProductCellViewModel?

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
        viewModel = nil
    }

    func setup(with viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        imageView.kf.setImage(with: viewModel.imageUrl)
        brandLabel.text = viewModel.brand
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price

        ratingView.setupContent(maxRate: viewModel.rating.max,
                                rate: viewModel.rating.current)
        favoriteButton.setState(active: viewModel.isFavorite)
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
