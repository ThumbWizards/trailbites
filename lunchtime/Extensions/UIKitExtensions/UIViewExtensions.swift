//
//  UIViewExtensions.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit


// MARK: - Subview manipulation helpers

public extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    func addSubviews(_ views: [UIView]) {
        for subview in views {
            addSubview(subview)
        }
    }
}

// MARK: - Layout

extension UIView {

    var autolayout: Bool {
        get {
            return !translatesAutoresizingMaskIntoConstraints
        }

        set(newValue) {
            translatesAutoresizingMaskIntoConstraints = !newValue
        }
    }

    @discardableResult
    func withAutoLayout() -> Self {
        autolayout = true
        return self
    }
}

// MARK: - Constraint helpers

public extension UIView {
    @objc func constraintsToFillSuperview(equalMargins: CGFloat) -> [NSLayoutConstraint] {
        return constraintsToFillSuperview(marginH: equalMargins, marginV: equalMargins)
    }

    @objc func constraintsToFillSuperview(margins: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        return constraintsToFillSuperviewHorizontally(leadingMargin: margins.left, trailingMargin: -margins.right)
                + constraintsToFillSuperviewVertically(topMargin: margins.top, bottomMargin: -margins.bottom)
    }

    @objc func constraintsToFillSuperview(marginH: CGFloat, marginV: CGFloat) -> [NSLayoutConstraint] {
        return constraintsToFillSuperviewHorizontally(margins: marginH)
                + constraintsToFillSuperviewVertically(margins: marginV)
    }

    @objc func constraintsToFillSuperviewHorizontally(margins: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraintsToFillSuperviewHorizontally(leadingMargin: margins, trailingMargin: -margins)
    }

    @objc func constraintsToFillSuperviewVertically(margins: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraintsToFillSuperviewVertically(topMargin: margins, bottomMargin: -margins)
    }

    @objc func constraintsToFillSuperviewHorizontally(leadingMargin: CGFloat, trailingMargin: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("This view does not have a superview: \(self)")
        }
        let leader = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingMargin)
        let trailer = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingMargin)
        return [leader, trailer]
    }

    @objc func constraintsToFillSuperviewVertically(topMargin: CGFloat, bottomMargin: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("This view does not have a superview: \(self)")
        }
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: topMargin)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomMargin)
        return [top, bottom]
    }
}

