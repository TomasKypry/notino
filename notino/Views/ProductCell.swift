//
//  ProductCell.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupStyles()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
    }

    func setup(with product: Product) {
    }

    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.pinSidesToContainer()
    }

    private func setupStyles() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
