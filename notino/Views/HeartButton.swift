//
//  HeartButton.swift
//  notino
//
//  Created by Tomáš Kyprý on 13.05.2022.
//

import UIKit

class HeartButton: UIButton {
    let onTap: ((_ active: Bool) -> Void)

    private var isActive = false
    private var isAnimating = false

    init(onTap: @escaping ((_ active: Bool) -> Void)) {
        self.onTap = onTap
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setState(active: Bool) {
        isActive = active
        setCorrectImage()
    }

    private func setup() {
        setCorrectImage()
        addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
        size(equalTo: 40)
    }

    private func setCorrectImage(animated: Bool = false) {
        let imageName = isActive ? "heart-fill" : "heart"
        let image = UIImage(named: imageName)

        isAnimating = true
        UIView.animate(withDuration: 0.2) {
            self.setImage(image, for: .normal)
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            self.transform = .identity
            self.isAnimating = false
        }
    }

    @objc private func onTapAction() {
        if isAnimating { return }

        isActive.toggle()
        setCorrectImage(animated: true)
        onTap(isActive)
    }
}

