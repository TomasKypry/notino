//
//  UIView+Constraints.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import UIKit

public extension UIView {
    @discardableResult
    func heightAnchor(equalTo constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutDimension>) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalTo: anchor)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func heightAnchor(min: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func heightAnchor(max: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: max)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func widthAnchor(equalTo constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    func widthAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: anchor, multiplier: 1, constant: constant).isActive = true
    }

    func size(equalTo constant: CGFloat) {
        widthAnchor(equalTo: constant)
        heightAnchor(equalTo: constant)
    }

    func centerY(equalTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }

    func centerX(equalTo anchor: NSLayoutXAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }

    func centerVerticaly(with view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerY(equalTo: view.centerYAnchor)
    }

    func centerHorizontaly(with view: UIView, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerX(equalTo: view.centerXAnchor, padding: padding)
    }

    func center(with view: UIView) {
        self.centerVerticaly(with: view)
        self.centerHorizontaly(with: view)
    }

    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor,
                   padding constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, padding  constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func leftAnchor(equalTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.leftAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func rightAnchor(equalTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.rightAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }

    func pinHorizontalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.leftAnchor(equalTo: view.leftAnchor, padding: padding)
        self.rightAnchor(equalTo: view.rightAnchor, padding: padding)
    }

    func pinVerticalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.topAnchor(equalTo: view.topAnchor, padding: padding)
        self.bottomAnchor(equalTo: view.bottomAnchor, padding: padding)
    }

    func pinHorizontalSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinHorizontalSides(toSidesOfView: container, padding: padding)
    }

    func pinVerticalSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinVerticalSides(toSidesOfView: container, padding: padding)
    }

    func pinSides(toSidesofView view: UIView, padding: CGFloat = 0) {
        self.pinVerticalSides(toSidesOfView: view, padding: padding)
        self.pinHorizontalSides(toSidesOfView: view, padding: padding)
    }

    func pinSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinSides(toSidesofView: container, padding: padding)
    }

    func pinSidesToContainer(padding: UIEdgeInsets) {
        pinTopToContainer(padding: padding.top)
        pinBottomToContainer(padding: padding.bottom)
        pinLeftToContainer(padding: padding.left)
        pinRightToContainer(padding: padding.right)
    }

    func pinSidesToContainer(HPadding: CGFloat = 0, VPadding: CGFloat = 0) {
        guard let container = superview else { return }
        pinHorizontalSides(toSidesOfView: container, padding: HPadding)
        pinVerticalSides(toSidesOfView: container, padding: VPadding)
    }

    @discardableResult
    func pinTop(toTopOfView view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor(equalTo: view.topAnchor, padding: padding)
    }

    func pinTopToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinTop(toTopOfView: container, padding: padding)
    }

    func pinBottom(toBottomOfView view: UIView, padding: CGFloat = 0) {
        bottomAnchor(equalTo: view.bottomAnchor, padding: padding)
    }

    func pinBottomToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinBottom(toBottomOfView: container, padding: padding)
    }

    @discardableResult
    func pinLeft(toLeftOfView view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        return leftAnchor(equalTo: view.leftAnchor, padding: padding)
    }

    func pinLeftToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinLeft(toLeftOfView: container, padding: padding)
    }

    @discardableResult
    func pinRight(toRightOfView view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        return rightAnchor(equalTo: view.rightAnchor, padding: padding)
    }

    func pinRightToContainer(padding: CGFloat = 0) {
        guard let container = superview else { return }
        pinRight(toRightOfView: container, padding: padding)
    }
}
