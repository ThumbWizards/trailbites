//
//  RoundedContainerView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

class RoundedContainerView: UIView {

    public init(backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.autolayout = true
        styleAsRoundedCard(backgroundColor: backgroundColor)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
