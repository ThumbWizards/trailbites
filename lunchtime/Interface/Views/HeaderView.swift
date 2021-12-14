//
//  HeaderView.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/5/21.
//

import Foundation
import Swift
import UIKit

class HeaderView: UIView {

    lazy var logo: UIImageView = {
        let image = UIImage(named: "headerLogo")?.withRenderingMode(.automatic)
        let imageView = UIImageView(image: image).withAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()

    private lazy var searchAndFilterView: SearchAndFilterView = {
        let view = SearchAndFilterView(frame: CGRect.zero).withAutoLayout()
        return view
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
        addSubviews([logo, searchAndFilterView])
    }

    private func setupConstraints() {
        var constraints = [
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchAndFilterView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: DesignConstants.spacing)
        ]
        constraints += searchAndFilterView.constraintsToFillSuperviewHorizontally()
        NSLayoutConstraint.activate(constraints)
    }

    func setSearchAndFilterDelegate(_ delegate: SearchAndFilterDelegate) {
        searchAndFilterView.delegate = delegate
    }
}

private extension DesignConstants {
    static let spacing: CGFloat = 8.0
}
