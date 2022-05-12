//
//  APIClient+Products.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

extension APIClient {
    func getProducts(completion: @escaping Completion<ProductsResponse>) {
        let request = ProductsRequest()
        sendRequest(request, completion: completion)
    }
}
