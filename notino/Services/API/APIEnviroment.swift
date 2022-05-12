//
//  APIEnviroment.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

enum APIEnviroment {
    case development

    var host: String {
        switch self {
        case .development:
            return "my-json-server.typicode.com"
        }
    }
}
