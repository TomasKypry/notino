//
//  Request.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
}
