//
//  MapViewController.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/9/21.
//

import Foundation
import MapKit
import UIKit

class MapViewController: UIViewController {

    let viewModel = MapViewModel()

    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero).withAutoLayout()
        map.delegate = self
        map.showsUserLocation = true
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setupViews() {
        view.backgroundColor = .background
        view.addSubview(mapView)
    }

    private func setupConstraints() {
        let constraints = mapView.constraintsToFillSuperview()
        NSLayoutConstraint.activate(constraints)
    }

    private func setupNotifications() {
        viewModel.locationUpdated = { [weak self] coordinate in
            //guard let coordinate = coordinate else { return }
            self?.centerMap()
            // self?.mapView.setCenter(coordinate, animated: false)
        }
    }

    private func centerMap() {
        guard let coordinate = viewModel.currentLocation else { return }
        let region = MKCoordinateRegion( center: coordinate,
                                         latitudinalMeters: CLLocationDistance(exactly: 5000)!,
                                         longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: false)

    }
}

extension MapViewController: MKMapViewDelegate {

}
