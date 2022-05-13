//
//  RatingView.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

class RatingView: UIView {
    private let contentStack = HStack(alignment: .center)

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(contentStack)
        contentStack.pinSidesToContainer()
    }

    func setupContent(maxRate: Int, rate: Int) {
        contentStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        for i in 0 ..< maxRate {
            let imageName = i <= rate ? "star-fill" : "star"
            let starImageView = UIImageView(image: UIImage(named: imageName))
            starImageView.size(equalTo: 14)
            contentStack.addArrangedSubview(starImageView)
        }
    }
}
