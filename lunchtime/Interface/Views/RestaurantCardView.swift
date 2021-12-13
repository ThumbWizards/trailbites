//
//  RestaurantCardView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

public class RestaurantCardView: UIView {

    private let roundedContainerView: UIView = RoundedContainerView(backgroundColor: UIColor.white).withAutoLayout()

    private lazy var mainStackView: UIStackView = {
        var arrangedSubviews = [UIStackView(arrangedSubviews: [imageView], axis: .horizontal),
                                StackViewSpacerView(axis: .horizontal, exactSpace: 8),
                                centerContentStack
                                ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews).withAutoLayout()
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero).withAutoLayout()
        image.widthAnchor.constraint(equalToConstant: 90).isActive = true
        image.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return image
    }()

    private lazy var centerContentStack: UIStackView = {
        var arrangedSubviews = [UIStackView(arrangedSubviews: [nameLabel, priceLabel], axis: .vertical),
                                StackViewSpacerView(axis: .vertical, exactSpace: 12)
                                ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews).withAutoLayout()
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .text
        label.text = "Hungry Howies"
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .text
        label.text = "$$$$$ - super expensive"
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        autolayout = true
    }

    convenience init(viewModel: RestuarantViewModel) {
        self.init(frame: .zero)
        updateWithViewModel(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(roundedContainerView)
        roundedContainerView.addSubview(mainStackView)

        roundedContainerView.layer.borderWidth = 1.0
        roundedContainerView.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
    }

    private func setupConstraints() {
        var constraints = roundedContainerView.constraintsToFillSuperview()
        constraints += mainStackView.constraintsToFillSuperview(marginH: 8, marginV: 8)
        constraints.forEach { $0.priority = UILayoutPriority(rawValue: 999) }
        NSLayoutConstraint.activate(constraints)
    }

    func updateWithViewModel(viewModel: RestuarantViewModel?) {
        guard let viewModel = viewModel else {
            resetView()
            return
        }
        nameLabel.text = viewModel.restaurant.name
        priceLabel.text = String(viewModel.restaurant.priceLevel ?? 0)
        isUserInteractionEnabled = true
    }

    private func resetView() {
        nameLabel.text = ""
        priceLabel.text = ""

    }
}
