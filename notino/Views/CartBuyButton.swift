//
//  CartBuyButton.swift
//  notino
//
//  Created by Tomáš Kyprý on 13.05.2022.
//

import UIKit

class CartBuyButton: UIButton {
    let onTap: VoidCallback

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }

    init(onTap: @escaping VoidCallback) {
        self.onTap = onTap
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        titleLabel?.font = .systemFont(ofSize: 11, weight: .light)
        setTitle("DO KOŠÍKU", for: .normal)
        setTitleColor(.black, for: .normal)
        addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
        contentEdgeInsets = .allSides(6)
    }

    @objc private func onTapAction() {
        onTap()
    }
}
