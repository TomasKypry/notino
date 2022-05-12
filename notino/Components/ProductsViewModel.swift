//
//  ProductsViewModel.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

class ProductsViewModel {
    private let apiClient: APIClient

    private(set) var products: [Product] = [] {
        didSet {
            onReloadNeeded?()
        }
    }

    var onReloadNeeded: VoidCallback?

    var numberOfItemsPerRow: Int {
        2
    }

    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }

    func fetchProducts() {
        apiClient.getProducts { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self?.products = [.init(),.init(),.init(),.init(),.init(),.init(),.init(),.init(),.init(),.init()]
            }
        }
    }
}
