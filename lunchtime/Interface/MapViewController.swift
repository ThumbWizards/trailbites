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
        setupListeners()
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

    private func setupListeners() {
        viewModel.locationUpdated = { [weak self] coordinate in
            self?.centerMap(toLocation: coordinate ?? Constants.CurrentLocationManager.defaultLocation)
            self?.viewModel.fetchNearbyRestaurants()
        }

        viewModel.restaurantsUpdated = { [weak self] in
            self?.updateMap()
        }
    }

    private func centerMap(toLocation coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion( center: coordinate,
                                         latitudinalMeters: CLLocationDistance(exactly: 5000)!,
                                         longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: false)
    }

    private func updateMap() {
        print("updateMap")
        let annotations = viewModel.annotations
        mapView.addAnnotations(annotations)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let restaurantAnnotation = view.annotation as? RestaurantPointAnnotation else {
            return
        }

        print("\(restaurantAnnotation.restaurant.name)")
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

        if let pinImage = UIImage(named: "annotation") {
            view?.image = pinImage
        }
        return view
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        viewModel.fetchNearbyRestaurants(at: center)
    }
}

private extension Constants {
    struct MapViewController {
        static let annotationIdentifier = "annotation_identifier"
    }
}
