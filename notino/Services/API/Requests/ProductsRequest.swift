//
//  ProductsRequest.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

struct ProductsRequest: Request {
    var path: String {
        "cernfr1993/notino-assignment/db"
    }

    var method: HTTPMethod {
        .get
    }
}
