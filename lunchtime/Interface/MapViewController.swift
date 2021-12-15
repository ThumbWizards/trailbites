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
        removeAllAnnotations()
        mapView.addAnnotations(annotations)
    }

    private func removeAllAnnotations() {
        let annotations = mapView.annotations.filter {
            $0 !== self.mapView.userLocation
        }
        mapView.removeAnnotations(annotations)
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }

        let identifier = Constants.MapViewController.annotationIdentifier
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view!.canShowCallout = true
        } else {
            view?.annotation = annotation
        }

        if let pinImage = UIImage(named: "annotation-unselected") {
            view?.image = pinImage
        }

        return view
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if presentedViewController != nil {
            dismiss(animated: false, completion: nil)
        }
        let center = mapView.centerCoordinate
        viewModel.fetchNearbyRestaurants(at: center)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let restaurantAnnotation = view.annotation as? RestaurantPointAnnotation else {
            return
        }

        if let pinImage = UIImage(named: "annotation-selected") {
            view.image = pinImage
        }

        let calloutController = UIViewController()
        let cardView = RestaurantCardView().withAutoLayout()
        cardView.updateWithViewModel(viewModel: RestuarantViewModel(restaurant: restaurantAnnotation.restaurant))
        calloutController.view = cardView

        calloutController.modalPresentationStyle = .popover

        let popover = calloutController.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = view
        popover?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.minY, width: 0, height: 0)

        popover?.permittedArrowDirections = [.up, .down]
        calloutController.preferredContentSize = CGSize(width: 280, height: 120)
        present(calloutController, animated: false)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let pinImage = UIImage(named: "annotation-unselected") {
            view.image = pinImage
        }
    }
}

extension MapViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

private extension Constants {
    struct MapViewController {
        static let annotationIdentifier = "annotation_identifier"
    }
}

class CustomPopoverBackgroundView: UIPopoverBackgroundView {

    private var offset = CGFloat(10)
    private var arrow = UIPopoverArrowDirection.any
    private var backgroundImageView: UIImageView!

    override var arrowDirection: UIPopoverArrowDirection {
        get { return arrow }
        set { arrow = newValue }
    }

    override var arrowOffset: CGFloat {
        get { return offset }
        set { offset = newValue }
    }

    override class func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }

    override class func arrowHeight() -> CGFloat {
        return 0
    }

    override class var wantsDefaultContentAppearance: Bool {
        return false
    }

    override func layoutSubviews() {
           super.layoutSubviews()

           var backgroundImageViewFrame = bounds

           switch arrowDirection {
           case .down:
               backgroundImageViewFrame.size.height -= CustomPopoverBackgroundView.arrowHeight()
           default:
               backgroundImageViewFrame.size.width -= CustomPopoverBackgroundView.arrowHeight()
               backgroundImageViewFrame.origin.x += CustomPopoverBackgroundView.arrowHeight()
           }

           backgroundImageView.frame = backgroundImageViewFrame
       }
}
