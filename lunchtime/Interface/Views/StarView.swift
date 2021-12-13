//
//  StarView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/13/21.
//

import Foundation
import UIKit

class StarView: UIView {

    let restaurant: Restaurant

    private lazy var starStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: stars()).withAutoLayout()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        return stackView
    }()


    private lazy var reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .text
        label.text = "(0)"
        return label
    }()
    

    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
                                                    StackViewSpacerView(axis: .horizontal, exactSpace: 20),
                                                   reviewsLabel], axis: .horizontal).withAutoLayout()

        return stack
    }()

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        addSubview(mainStack)
    }

    private func setupConstraints() {
        let constraints = mainStack.constraintsToFillSuperview(margins: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
        NSLayoutConstraint.activate(constraints)
    }

    func stars() -> [UIImageView] {
        return []
    }
}
