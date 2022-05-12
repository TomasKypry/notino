//
//  ReusableCells.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        register(T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
