//
//  Stack.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

class VStack: UIStackView {
    init(_ views: [UIView?] = [],
         spacing: CGFloat = 0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        views.forEach {
            if let view = $0 {
                addArrangedSubview(view)
            }
        }
        axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }

    convenience init(spacing: CGFloat = 0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     views: (() -> [UIView?])) {
        self.init(views(), spacing: spacing, alignment: alignment, distribution: distribution)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HStack: UIStackView {
    init(_ views: [UIView?] = [],
         spacing: CGFloat = 0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        views.forEach {
            if let view = $0 {
                addArrangedSubview(view)
            }
        }
        axis = .horizontal
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }

    convenience init(spacing: CGFloat = 0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     views: (() -> [UIView?])) {
        self.init(views(), spacing: spacing, alignment: alignment, distribution: distribution)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
