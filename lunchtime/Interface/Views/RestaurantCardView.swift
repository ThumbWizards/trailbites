//
//  RestaurantCardView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

public class RestaurantCardView: UIView {

    var viewModel: RestuarantViewModel?

    private let roundedContainerView: UIView = RoundedContainerView(backgroundColor: UIColor.white).withAutoLayout()

    private var contentView: UIView = {
        let view = UIView(frame: .zero).withAutoLayout()
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero).withAutoLayout()
        imageView.image = UIImage(named: "comingsoon")
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        return imageView
    }()

    private lazy var detailsView: UIView = {
        let view = UIView(frame: .zero).withAutoLayout()
        view.addSubviews([nameLabel,
                          starView,
                          reviewsLabel,
                          priceLabel])
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel().withAutoLayout()
        label.font = UIFont.font(size: 14, weight: .semibold)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .darkText
        label.text = "Hungry Howies"
        return label
    }()

    private lazy var starView: StarView = {
        let view = StarView().withAutoLayout()
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return view
    }()

    private lazy var reviewsLabel: UILabel = {
        let label = UILabel().withAutoLayout()
        label.font = UIFont.font(size: 12, weight: .light)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .text
        label.text = "(1018)"
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel().withAutoLayout()
        label.font = UIFont.font(size: 12, weight: .light)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .text
        label.text = "$$$$$ • super expensive"
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
        self.viewModel = viewModel
        updateWithViewModel(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(roundedContainerView)
        roundedContainerView.addSubview(contentView)
        roundedContainerView.layer.borderWidth = 1.0
        roundedContainerView.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor

        contentView.addSubviews([imageView, detailsView])
    }

    private func setupConstraints() {
        var constraints = roundedContainerView.constraintsToFillSuperview()
        constraints += contentView.constraintsToFillSuperview(marginH: 16, marginV: 16)

        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true

        detailsView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 2).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -2).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        nameLabel.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 4).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor).isActive = true

        starView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        starView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: -2).isActive = true

        reviewsLabel.centerYAnchor.constraint(equalTo: starView.centerYAnchor).isActive = true
        reviewsLabel.leadingAnchor.constraint(equalTo: starView.trailingAnchor, constant: 8).isActive = true

        priceLabel.topAnchor.constraint(equalTo: starView.bottomAnchor, constant: 4).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor).isActive = true

        //constraints.forEach { $0.priority = UILayoutPriority(rawValue: 999) }
        NSLayoutConstraint.activate(constraints)
    }

    func updateWithViewModel(viewModel: RestuarantViewModel?) {
        guard let viewModel = viewModel else {
            resetView()
            return
        }
        self.viewModel = viewModel
        let starViewModel = StarViewModel(restaurant: viewModel.restaurant)
        starView.updateWithViewModel(viewModel: starViewModel)
        nameLabel.text = viewModel.restaurant.name
        priceLabel.text = viewModel.priceText
        reviewsLabel.text = "(\(viewModel.restaurant.userRatings ?? 0))"
        isUserInteractionEnabled = true
    }

    private func resetView() {
        starView.updateWithViewModel(viewModel: nil)
        nameLabel.text = ""
        priceLabel.text = ""
        reviewsLabel.text = ""

    }
}
