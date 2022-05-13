//
//  Product.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

struct Product: Codable {
    let productId: Int
    let name: String
    let annotation: String
    let imageUrl: String
    let brand: Brand
    let price: Price
    let reviewSummary: Review
}

extension Product {
    struct Brand: Codable {
        let name: String
    }

    struct Price: Codable {
        let value: Decimal
        let currency: Currency
    }

    enum Currency: String, Codable {
        case czk = "CZK"
    }

    struct Review: Codable {
        let score: Int
        let averageRating: Double
    }
}
