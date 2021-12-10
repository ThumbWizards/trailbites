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
        var arrangedSubviews = [dateStackView,
                                StackViewSpacerView(axis: .vertical, exactSpace: 12),
                                detailsStackView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews).withAutoLayout()
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel]).withAutoLayout()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [jumpCountStackView, caloriesStackView, jumpTimeStackView]).withAutoLayout()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var jumpCountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [jumpCountLabel, jumpCountTitleLabel]).withAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var jumpCountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var jumpCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 18, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var jumpTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [jumpTimeLabel, jumpTimeTitleLabel]).withAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var jumpTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var jumpTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 18, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var caloriesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [caloriesLabel, caloriesTitleLabel]).withAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var caloriesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 12, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
        return label
    }()

    private lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(size: 18, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.text
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
        constraints += mainStackView.constraintsToFillSuperview(marginH: 16, marginV: 16)
        constraints += detailsStackView.constraintsToFillSuperviewHorizontally()
        constraints.forEach { $0.priority = UILayoutPriority(rawValue: 999) }
        NSLayoutConstraint.activate(constraints)
    }

    func updateWithViewModel(viewModel: RestuarantViewModel?) {
        guard let viewModel = viewModel else {
            resetView()
            return
        }
        _ = viewModel.restaurant.name
        isUserInteractionEnabled = true
    }

    private func resetView() {
        dateLabel.text = nil
        jumpTimeLabel.text = nil
        caloriesLabel.text  = nil
    }
}
