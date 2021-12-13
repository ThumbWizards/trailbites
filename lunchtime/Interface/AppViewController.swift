//
//  AppViewController.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/1/21.
//

import UIKit

class AppViewController: UIViewController {

    let viewModel = AppViewModel()

    private lazy var headerView: HeaderView = {
        let view = HeaderView(frame: CGRect.zero).withAutoLayout()
        return view
    }()

    lazy var listView: UIView = {
        let viewController = ListViewController()
        add(viewController)
        viewController.view.withAutoLayout()
        return viewController.view
    }()

    lazy var mapView: UIView = {
        let viewController = MapViewController()
        add(viewController)
        viewController.view.withAutoLayout()
        return viewController.view
    }()

    lazy var listMapButton: FloatingActionButton = {
        let button = FloatingActionButton(state: .map).withAutoLayout()
        button.widthAnchor.constraint(equalToConstant: 110).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(self, action:#selector(swapScreen), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        view.bringSubviewToFront(headerView)
        view.bringSubviewToFront(listMapButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibleView()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.background
        view.addSubviews([headerView, listMapButton])

        headerView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowRadius = 1.5
        headerView.layer.cornerRadius = headerView.frame.size.height / 2
        headerView.layer.masksToBounds =  false

        listMapButton.withElevation()
        listMapButton.buttonState = viewModel.floatingButtonState()
    }

    private func setupConstraints() {
        var constraints = headerView.constraintsToFillSuperviewHorizontally()
        constraints.append(headerView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(headerView.heightAnchor.constraint(equalToConstant: 155))

        constraints += listView.constraintsToFillSuperviewHorizontally()
        constraints.append(listView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        constraints.append(listView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        constraints += mapView.constraintsToFillSuperviewHorizontally()
        constraints.append(mapView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        constraints.append(mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        constraints.append(listMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48))
        constraints.append(listMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func swapScreen() {
        viewModel.currentView = (viewModel.currentView == .map) ? .list : .map
        listMapButton.buttonState = viewModel.floatingButtonState()
        updateVisibleView()
    }

    private func updateVisibleView() {
        let listAlpha = (viewModel.currentView == .list) ? 1.0 : 0.0
        let mapAlpha = (viewModel.currentView == .map) ? 1.0 : 0.0
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.listView.alpha = CGFloat(listAlpha)
            self?.mapView.alpha = CGFloat(mapAlpha)
        }
    }
}
