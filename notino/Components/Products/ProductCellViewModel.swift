//
//  ProductCellViewModel.swift
//  notino
//
//  Created by Tomáš Kyprý on 13.05.2022.
//

import Foundation

class ProductCellViewModel {
    private let product: Product

    var isFavorite = false

    var onFavoriteChange: ((Bool) -> Void)?

    init(product: Product) {
        self.product = product
    }

    var id: Int {
        product.productId
    }

    var brand: String {
        product.brand.name
    }

    var name: String {
        product.name
    }

    var description: String {
        product.annotation
    }

    var rating: (max: Int, current: Int) {
        (product.reviewSummary.score, Int(product.reviewSummary.averageRating))
    }

    var imageUrl: URL? {
        URL(string: Constants.imagePrefixUrl + product.imageUrl)
    }

    var price: String? {
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
}
