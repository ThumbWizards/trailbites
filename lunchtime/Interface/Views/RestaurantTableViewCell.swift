//
//  RestaurantTableViewCell.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

class RestaurantTableViewCell: UITableViewCell {

    var viewModel: RestuarantViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            restaurantCardView.updateWithViewModel(viewModel: viewModel)
        }
    }

    private lazy var restaurantCardView: RestaurantCardView = {
        let cardView = RestaurantCardView().withAutoLayout()
        return cardView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        autolayout = true
        setupViews()
        setupConstraints()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        restaurantCardView.updateWithViewModel(viewModel: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding is not supported")
    }

    private func setupViews() {
        contentView.addSubview(restaurantCardView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(restaurantCardView.constraintsToFillSuperview(marginH: 24, marginV: 6))
    }
}
