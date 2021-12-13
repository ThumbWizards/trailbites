//
//  StarView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/13/21.
//

import Foundation
import UIKit

class StarView: UIView {

    var viewModel: StarViewModel?

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starStack], axis: .vertical).withAutoLayout()
        return stack
    }()

    private var starStack: UIStackView {
        let stackView = UIStackView(arrangedSubviews: stars(), axis: .horizontal).withAutoLayout()
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.axis = .horizontal
        return stackView
    }

    private func setupViews() {
        backgroundColor = .white
        addSubview(mainStack)
    }

    private func setupConstraints() {
        let constraints = mainStack.constraintsToFillSuperview(margins: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        NSLayoutConstraint.activate(constraints)
    }

    func updateWithViewModel(viewModel: StarViewModel?) {
        guard let viewModel = viewModel else {
            resetView()
            return
        }
        self.viewModel = viewModel
        setupViews()
        setupConstraints()
    }

    private func resetView() {
        starStack.removeArrangedSubviews()
        mainStack.removeArrangedSubviews()
        removeAllSubviews()
    }

    private func stars() -> [UIImageView] {
        guard let viewModel = viewModel else {
            return []
        }

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
