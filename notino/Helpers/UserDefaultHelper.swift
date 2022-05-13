//
//  UserDefaultHelper.swift
//  notino
//
//  Created by Tomáš Kyprý on 13.05.2022.
//

import Foundation

struct UserDefaultHelper {
    static var favoritesProductsIds: [Int] {
        get {
            UserDefaults.standard.object(forKey: "favorites_products") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: "favorites_products")
        }
    }
}
