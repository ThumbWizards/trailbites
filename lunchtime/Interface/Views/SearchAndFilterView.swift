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
    func tapFilter(fromView: UIView)
}

class SearchAndFilterView: UIView {

    var delegate: SearchAndFilterDelegate?
    let restaurantsDataSource: RestaurantsDataSource

    lazy var filterButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 64).isActive = true
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont.font(size: 14, weight: .regular)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.75).cgColor
        button.styleWithRoundedCorners(cornerRadius: 8)
        button.layer.masksToBounds = true
        button.addTarget(self, action:#selector(tapFilter(_:)), for: .touchUpInside)
        return button
    }()

    lazy var textField: PaddedTextField = {
        let textField = PaddedTextField(frame: CGRect.zero)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText,
                          NSAttributedString.Key.font : UIFont.font(size: 14, weight: .bold)]
        textField.attributedPlaceholder = NSAttributedString(string: "Search for a restaurant", attributes:attributes)
        textField.styleWithRoundedCorners(cornerRadius: 8)
        textField.delegate = self
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.textColor = UIColor.darkText
        textField.font = UIFont.font(size: 14, weight: .bold)
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.75).cgColor
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.text.cgColor
        textField.layer.shadowRadius = 1
        return textField
    }()

    lazy var contentStack: UIStackView = {
        return UIStackView(arrangedSubviews: [filterButton, StackViewSpacerView(axis: .horizontal, exactSpace: 20), textField], axis: .horizontal).withAutoLayout()
    }()

    init(restaurantsDataSource: RestaurantsDataSource = RestaurantsNearbyLocationProvider.sharedManager) {
        self.restaurantsDataSource = restaurantsDataSource
        super.init(frame: .zero)
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
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func tapFilter(_ sender: UIButton) {
        delegate?.tapFilter(fromView: sender)
    }
}

extension SearchAndFilterView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) { }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        restaurantsDataSource.fetchRestaurants(closestTo: .last, searchFilter: text)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
