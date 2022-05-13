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

    private var cellViewModels: [ProductCellViewModel] = []

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

    func cellViewModel(for indexPath: IndexPath) -> ProductCellViewModel {
        let viewModel = cellViewModels[indexPath.item]
        viewModel.isFavorite = favoriteIds.contains(viewModel.id)
        viewModel.onFavoriteChange = { [weak self] favorite in
            self?.saveFavoriteState(id: viewModel.id, isFavorite: favorite)
        }
        return viewModel
    }

    func fetchProducts() {
        apiClient.getProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self.products = response.products
                self.cellViewModels = self.products.map { ProductCellViewModel(product: $0 ) }
            }
        }
    }

    private func saveFavoriteState(id: Int, isFavorite: Bool) {
        if isFavorite {
            favoriteIds.insert(id)
        } else {
            favoriteIds.remove(id)
        }
        UserDefaultHelper.favoritesProductsIds = Array(favoriteIds)
    }
}
