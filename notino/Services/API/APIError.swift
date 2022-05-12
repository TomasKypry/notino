//
//  APIError.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

struct APIError: Error {
    enum ErrorType {
        case unknown(String)
        case unableToCreateRequest(String)
        case communicationError(String)
        case unableToParseResponse(String)
    }

    let type: ErrorType

    init(_ type: ErrorType) {
        self.type = type
    }
}
