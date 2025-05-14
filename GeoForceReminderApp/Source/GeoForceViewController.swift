//
//  GeoForceViewController.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 12/05/2025.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Combine

class GeoForceViewController: UIViewController {

    // MARK: - Properties
    var viewModel = GeoForceViewModel()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupMapView()
        viewModel.fetchLocations()
        addZoomControls()
    }

    // MARK: - Setup Methods
    private func setupBindings() {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.updateAnnotations(with: locations)
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showError(message)
                }
            }
            .store(in: &cancellables)
    }

    private func setupMapView() {
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    private func updateAnnotations(with locations: [LocationsArray]) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = locations.map { location -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat ?? 0.0, longitude: location.lon ?? 0.0)
            return annotation
        }
        mapView.addAnnotations(annotations)
    }

    private func showError(_ message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlert, animated: true, completion: nil)
    }

    // MARK: - Zoom Controls
    private func addZoomControls() {
        let zoomInButton = UIButton(type: .system)
        zoomInButton.setTitle("+", for: .normal)
        zoomInButton.backgroundColor = .white
        zoomInButton.layer.cornerRadius = 5
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)

        let zoomOutButton = UIButton(type: .system)
        zoomOutButton.setTitle("-", for: .normal)
        zoomOutButton.backgroundColor = .white
        zoomOutButton.layer.cornerRadius = 5
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)

        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)

        NSLayoutConstraint.activate([
            zoomInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            zoomInButton.widthAnchor.constraint(equalToConstant: 40),
            zoomInButton.heightAnchor.constraint(equalToConstant: 40),

            zoomOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -10),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 40),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func zoomIn() {
        let region = mapView.region
        let span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta / 2, longitudeDelta: region.span.longitudeDelta / 2)
        let newRegion = MKCoordinateRegion(center: region.center, span: span)
        mapView.setRegion(newRegion, animated: true)
    }

    @objc private func zoomOut() {
        let region = mapView.region
        let span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 2, longitudeDelta: region.span.longitudeDelta * 2)
        let newRegion = MKCoordinateRegion(center: region.center, span: span)
        mapView.setRegion(newRegion, animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension GeoForceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomAnnotation"

        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.tintColor = UIColor.blue
            return annotationView
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        let alertController = UIAlertController(title: "Set Geofence", message: "Select a radius for the geofence (in meters):", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Enter radius (100-1000 meters)"
            textField.keyboardType = .numberPad
        }

        let setAction = UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            guard let radiusText = alertController.textFields?.first?.text,
                  let radius = Double(radiusText),
                  radius >= 100, radius <= 1000 else {
                self?.showError("Invalid radius. Please enter a value between 100 and 1000.")
                return
            }

            self?.viewModel.setGeofence(for: annotation, radius: radius, locationManager: self!.locationManager, mapView: self!.mapView)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(setAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.3)
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

// MARK: - CLLocationManagerDelegate
extension GeoForceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("User entered the area!")
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("User exited the area!")
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed to monitor region: \(region?.identifier ?? "Unknown") with error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        print("Location updated: \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location: \(error.localizedDescription)")
    }
}

