//
//  ProductsViewModel.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

class ProductsViewModel {
    private let apiClient: APIClient

    private(set) var products: [Product] = [] {
        didSet {
            onReloadNeeded?()
        }
    }

    private var favoriteIds: Set<Int> = []

    var onReloadNeeded: VoidCallback?

    var numberOfItemsPerRow: Int {
        2
    }

    var itemSpacing: CGFloat {
        20
    }

    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
        favoriteIds = Set<Int>(UserDefaultHelper.favoritesProductsIds)
    }

    func saveFavoriteState(product: Product, isFavorite: Bool) {
        if isFavorite {
            favoriteIds.insert(product.productId)
        } else {
            favoriteIds.remove(product.productId)
        }
        UserDefaultHelper.favoritesProductsIds = Array(favoriteIds)
    }

    func isFavorite(product: Product) -> Bool {
        return favoriteIds.contains(product.productId)
    }

    func fetchProducts() {
        apiClient.getProducts { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self?.products = response.products
            }
        }
    }
}
