//
//  SearchAndFilterView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import Swift
import UIKit

class SearchAndFilterView: UIView {

    lazy var filterButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 64).isActive = true
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        button.styleWithRoundedCorners(cornerRadius: 8)
        button.layer.masksToBounds = true
        return button
    }()

    lazy var textField: PaddedTextField = {
        let textField = PaddedTextField(frame: CGRect.zero)
        textField.placeholder = "Search for a restaurant"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        textField.styleWithRoundedCorners(cornerRadius: 8)
        textField.layer.masksToBounds = true
        return textField
    }()

    lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [filterButton, StackViewSpacerView(axis: .horizontal, exactSpace: 20), textField], axis: .horizontal).withAutoLayout()

        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        addSubview(contentStack)
    }

    private func setupConstraints() {
        let constraints = contentStack.constraintsToFillSuperview(margins: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
        NSLayoutConstraint.activate(constraints)
    }
}
