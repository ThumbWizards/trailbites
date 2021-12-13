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
    let notifier: Notifier

    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero).withAutoLayout()
        map.delegate = self
        map.showsUserLocation = true
        return map
    }()

    init(notifier: Notifier = Notifier()) {
        self.notifier = notifier
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            self?.centerMap(toLocation: coordinate ?? Constants.CurrentLocationManager.defaultLocation)
            self?.viewModel.fetchNearbyRestaurants()
        }

        notifier.notify(.resturantsDataSourceDidUpdate) { [weak self] _ in
            self?.updateMap()
        }
    }

    private func centerMap(toLocation coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion( center: coordinate,
                                         latitudinalMeters: CLLocationDistance(exactly: 2500)!,
                                         longitudinalMeters: CLLocationDistance(exactly: 2500)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: false)
    }

    private func updateMap() {
        print("updateMap")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("did select annotation")
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }

        let identifier = Constants.MapViewController.annotationIdentifier
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view!.canShowCallout = true // standard callout
        } else {
            view?.annotation = annotation
        }

        if let pinImage = UIImage(systemName: "pin") {
            view?.image = pinImage
        }
        return view
    }
}

private extension Constants {
    struct MapViewController {
        static let annotationIdentifier = "annotation_identifier"
    }
}
