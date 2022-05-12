//
//  ProductsResponse.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

struct ProductsResponse: Response {
    let products: [Product]

    private enum CodingKeys: String, CodingKey {
        case products = "vpProductByIds"
    }
}
