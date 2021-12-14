//
//  SearchAndFilterView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import Swift
import UIKit

protocol SearchAndFilterDelegate {
    func didSearch(withText: String)
    func tapFilter(fromView: UIView)
}

class SearchAndFilterView: UIView {

    var delegate: SearchAndFilterDelegate?

    lazy var filterButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 64).isActive = true
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont.font(size: 14, weight: .regular)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        button.styleWithRoundedCorners(cornerRadius: 8)
        button.layer.masksToBounds = true
        button.addTarget(self, action:#selector(tapFilter(_:)), for: .touchUpInside)
        return button
    }()

    lazy var textField: PaddedTextField = {
        let textField = PaddedTextField(frame: CGRect.zero)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText,
                          NSAttributedString.Key.font : UIFont.font(size: 14, weight: .semibold)]
        textField.attributedPlaceholder = NSAttributedString(string: "Search for a restaurant", attributes:attributes)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        textField.styleWithRoundedCorners(cornerRadius: 8)
        textField.layer.masksToBounds = true
        textField.delegate = self
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

    @objc private func tapFilter(_ sender: UIButton) {
        delegate?.tapFilter(fromView: sender)
    }
}

extension SearchAndFilterView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        delegate?.didSearch(withText: text)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didSearch(withText: "begin editing")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
