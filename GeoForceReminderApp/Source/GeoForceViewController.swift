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

class GeoForceViewController: UIViewController {

    // MARK: - Properties
    var viewModel: GeoForceViewModel?
    private var locationManager: CLLocationManager? // Added property

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GeoForceViewModel()
        setupMapView()
        fetchAndDisplayLocations()
        addZoomControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Map Setup
    private func setupMapView() {
        locationManager?.delegate = self
        mapView.delegate = self
    }

    private func fetchAndDisplayLocations() {
        viewModel?.getLocations { [weak self] msg, success in
            guard let self = self, success else {
                print(msg ?? "Failed to fetch locations")
                return
            }

            self.addAnnotationsToMap()
        }
    }

    private func addAnnotationsToMap() {
        guard let locations = viewModel?.locations else { return }

        let annotations = locations.map { location -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat ?? 0.0, longitude: location.lon ?? 0.0)
            return annotation
        }

        mapView.addAnnotations(annotations)
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

            self?.setGeofence(for: annotation, radius: radius)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(setAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func setGeofence(for annotation: MKAnnotation, radius: Double) {
        setupGeofenceMonitoring(for: annotation, radius: radius)
        print("Geofence set for annotation at \(annotation.coordinate) with radius \(radius) meters.")
    }

    private func showError(_ message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlert, animated: true, completion: nil)
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

    private func setupGeofenceMonitoring(for annotation: MKAnnotation, radius: Double) {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            print("Geofencing is not supported on this device!")
            return
        }

        let center = annotation.coordinate
        let region = CLCircularRegion(center: center, radius: radius, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startMonitoring(for: region)
    }
}

extension GeoForceViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}
