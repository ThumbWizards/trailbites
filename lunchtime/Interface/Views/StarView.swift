//
//  StarView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/13/21.
//

import Foundation
import UIKit

class StarView: UIView {

    private var viewModel: StarViewModel

    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero).withAutoLayout()
        view.addSubview(starStack)
        return view
    }()

    private var starStack: UIStackView {
        let stackView = UIStackView(arrangedSubviews: stars(), axis: .horizontal).withAutoLayout()
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.axis = .horizontal
        return stackView
    }

    init(viewModel: StarViewModel = StarViewModel(restaurant: PlaceholderRestaurant())) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWithViewModel(viewModel: StarViewModel?) {
        guard let viewModel = viewModel else {
            resetView()
            return
        }
        self.viewModel = viewModel
        starStack.addArrangedSubviews(stars())
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func resetView() {
        starStack.removeArrangedSubviews()
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func setupViews() {
        addSubview(contentView)
    }

    private func setupConstraints() {
        let constraints = contentView.constraintsToFillSuperview()
        NSLayoutConstraint.activate(constraints)
    }

    private func stars() -> [UIImageView] {
        var views = [UIImageView]()
        for _ in 0..<viewModel.illuminatedStarCount {
            views.append(star(illuminated: true))
        }
        for _ in 0..<viewModel.deluminatedStarCount {
            views.append(star(illuminated: false))
        }
        return views
    }

    private func star(illuminated: Bool) -> UIImageView {
        let image: UIImage?
        if illuminated {
            image = UIImage(systemName: "star.fill")?.withTintColor(UIColor.starAccent, renderingMode: .alwaysOriginal)
        } else {
            image = UIImage(systemName: "star.fill")?.withTintColor(UIColor.star, renderingMode: .alwaysOriginal)
        }
        let imageView = UIImageView(image: image).withAutoLayout()
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return UIImageView(image: image)
    }
}
