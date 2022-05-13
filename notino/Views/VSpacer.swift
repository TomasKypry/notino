//
//  VSpacer.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

class VSpacer: UIView {
    init(_ space: CGFloat) {
        super.init(frame: .zero)
        heightAnchor(equalTo: space)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
