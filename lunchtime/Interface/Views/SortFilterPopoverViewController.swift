//
//  SortFilterPopoverViewController.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/14/21.
//

import Foundation
import UIKit

extension Notification.Name {
    static let filterUpdated = Notification.Name(rawValue: "filterUpdated")
}

class SortFilterPopoverViewController: UIViewController {

    let notificationProvider: NotificationProvider
    let ascendingFilterEnabled: BooleanSetting

    var isAscending = false

    lazy var contentView: UIView = {
        let view = UIView(frame: .zero).withAutoLayout()
        return view
    }()

    lazy var highToLowLabel: UILabel = {
        let label = UILabel(frame: .zero).withAutoLayout()
        label.text = "Ratings High to Low"
        label.font = UIFont.font(size: 12, weight: .regular)
        label.textColor = UIColor.text
        return label
    }()

    lazy var lowToHighLabel: UILabel = {
        let label = UILabel(frame: .zero).withAutoLayout()
        label.text = "Ratings Low to High"
        label.font = UIFont.font(size: 12, weight: .regular)
        label.textColor = UIColor.text
        return label
    }()

    private lazy var highToLowButton: UIButton = {
        let button = UIButton(frame: .zero).withAutoLayout()
        button.addTarget(self, action:#selector(tapHighToLow), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.imageView?.layer.borderWidth = 1.0
        button.imageView?.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        button.imageView?.styleWithRoundedCorners(cornerRadius: 8)
        button.imageView?.layer.masksToBounds = true
        return button
    }()

    private lazy var lowToHighButton: UIButton = {
        let button = UIButton(frame: .zero).withAutoLayout()
        button.addTarget(self, action:#selector(tapLowToHigh), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.imageView?.layer.borderWidth = 1.0
        button.imageView?.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        button.imageView?.styleWithRoundedCorners(cornerRadius: 8)
        button.imageView?.layer.masksToBounds = true
        return button
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton(frame: .zero).withAutoLayout()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(UIColor.accent, for: .normal)
        button.titleLabel?.font = UIFont.font(size: 13, weight: .semibold)
        button.addTarget(self, action:#selector(tapApply), for: .touchUpInside)
        return button
    }()

    init(notificationProvider: NotificationProvider = NotificationCenter.default,
         ratingsFilterAscending: BooleanSetting = Settings.ratingsFilterAscending) {
        self.notificationProvider = notificationProvider
        self.ascendingFilterEnabled = ratingsFilterAscending
        super.init(nibName: nil, bundle: nil)
        isAscending = ascendingFilterEnabled.value

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        view.backgroundColor = UIColor.background
        view.addSubview(contentView)
        contentView.addSubviews([lowToHighLabel, lowToHighButton, highToLowLabel, highToLowButton, applyButton])
        refreshFilterUI()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(contentView.constraintsToFillSuperview())

        highToLowButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        highToLowButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

        highToLowLabel.leadingAnchor.constraint(equalTo: highToLowButton.trailingAnchor, constant: 4).isActive = true
        highToLowLabel.centerYAnchor.constraint(equalTo: highToLowButton.centerYAnchor).isActive = true
        highToLowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4).isActive = true

        lowToHighButton.topAnchor.constraint(equalTo: highToLowButton.bottomAnchor, constant: 2).isActive = true
        lowToHighButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

        lowToHighLabel.leadingAnchor.constraint(equalTo: lowToHighButton.trailingAnchor, constant: 4).isActive = true
        lowToHighLabel.centerYAnchor.constraint(equalTo: lowToHighButton.centerYAnchor).isActive = true
        lowToHighLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4).isActive = true

        applyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    @objc private func tapLowToHigh() {
        print("lowToHigh")
        isAscending = true
        refreshFilterUI()
    }

    @objc private func tapHighToLow() {
        print("highToLow")
        isAscending = false
        refreshFilterUI()
    }

    @objc private func tapApply() {
        print("apply")
        ascendingFilterEnabled.value = isAscending
        notificationProvider.postNotification(name: Notification.Name.filterUpdated.rawValue, object: nil, userInfo: nil)
    }

    func refreshFilterUI() {
        if isAscending {
            lowToHighButton.setImage(UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor.accent, renderingMode: .alwaysOriginal), for: .normal)
            highToLowButton.setImage(UIImage.init(systemName: "circle")?.withTintColor(UIColor.clear, renderingMode: .alwaysOriginal), for: .normal)

            lowToHighButton.imageView?.layer.borderColor = UIColor.clear.cgColor
            highToLowButton.imageView?.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
        } else {
            lowToHighButton.setImage(UIImage.init(systemName: "circle")?.withTintColor(UIColor.clear, renderingMode: .alwaysOriginal), for: .normal)
            highToLowButton.setImage(UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor.accent, renderingMode: .alwaysOriginal), for: .normal)

            lowToHighButton.imageView?.layer.borderColor = UIColor.border.withAlphaComponent(0.5).cgColor
            highToLowButton.imageView?.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
