//
//  StackViewSpacerView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

public class StackViewSpacerView: UIView {

    init(axis: NSLayoutConstraint.Axis, minimumSpace: CGFloat) {
        super.init(frame: CGRect.zero)
        setContentHuggingPriority(.defaultLow, for: axis)
        let anchor = (axis == .vertical ? heightAnchor : widthAnchor)
        let constraint = anchor.constraint(greaterThanOrEqualToConstant: minimumSpace)
        constraint.priority = UILayoutPriority(rawValue: 999)
        constraint.isActive = true
        isAccessibilityElement = false
    }

    init(axis: NSLayoutConstraint.Axis, exactSpace: CGFloat) {
        super.init(frame: CGRect.zero)
        setContentHuggingPriority(.required, for: axis)
        let anchor = (axis == .vertical ? heightAnchor : widthAnchor)
        let constraint = anchor.constraint(equalToConstant: exactSpace)
        constraint.priority = UILayoutPriority(rawValue: 999)
        constraint.isActive = true
        isAccessibilityElement = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
