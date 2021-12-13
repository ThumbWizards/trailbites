//
//  ListViewController.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    let viewModel = ListViewModel()

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(fetchAndReloadData), for: .valueChanged)
        control.tintColor = UIColor.button
        return control
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped).withAutoLayout()
        table.delegate = self
        table.dataSource = self
        table.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.defaultReuseIdentifier)
        table.refreshControl = refreshControl
        table.backgroundColor = UIColor.background
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupListeners()
    }

    private func setupViews() {
        view.backgroundColor = .background
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        let constraints = tableView.constraintsToFillSuperview()
        NSLayoutConstraint.activate(constraints)
    }

    private func setupListeners() {
        viewModel.restaurantsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc private func fetchAndReloadData() {
        viewModel.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.restaurantsNearby.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.defaultReuseIdentifier, for: indexPath) as! RestaurantTableViewCell

        if let restaurant = viewModel.restaurantsNearby.subscriptSafe(indexPath.section) {
            cell.viewModel = RestuarantViewModel(restaurant: restaurant)
        }
        return cell
    }
}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 16
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

}
