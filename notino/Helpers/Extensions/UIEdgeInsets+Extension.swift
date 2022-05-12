//
//  UIEdgeInsets+Extension.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

extension UIEdgeInsets {
    static func allSides(_ padding: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }

    /// Total horizontal padding. Sum of left and right paddings
    var horizontal: CGFloat {
        left + right
    }
}
