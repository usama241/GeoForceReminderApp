//
//  GeoForceViewModel.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 12/05/2025.
//

import Foundation
import Combine
import MapKit
import CoreLocation

class GeoForceViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var locations: [LocationsArray] = []
    @Published var errorMessage: String? = nil

    // MARK: - Methods
    func fetchLocations() {
        guard let url = URL(string: "https://gist.githubusercontent.com/usama241/41e0cdcac7055e83cd9665c3ad4af89f/raw/0131631c669dd492faaceb01dc3d417fd1034301/locations.json") else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    self?.errorMessage = "Invalid response or no data received"
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LocationsResponse.self, from: data)

                    if httpResponse.statusCode == 200 {
                        self?.locations = response.locations ?? []
                    } else {
                        self?.errorMessage = response.responseDescription ?? "Unknown error"
                    }
                } catch {
                    self?.errorMessage = "Failed to decode response"
                }
            }
        }

        task.resume()
    }

    func setupGeofenceMonitoring(for annotation: MKAnnotation, radius: Double, locationManager: CLLocationManager) {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            errorMessage = "Geofencing is not supported on this device!"
            return
        }

        let center = annotation.coordinate
        let region = CLCircularRegion(center: center, radius: radius, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true

        locationManager.startMonitoring(for: region)
        print("Started monitoring region: \(region.identifier) at \(center) with radius \(radius) meters.")
    }

    func drawGeofenceCircle(center: CLLocationCoordinate2D, radius: Double, mapView: MKMapView) {
        DispatchQueue.main.async {
            mapView.removeOverlays(mapView.overlays)
            let circle = MKCircle(center: center, radius: radius)
            mapView.addOverlay(circle)
        }
    }

    func setGeofence(for annotation: MKAnnotation, radius: Double, locationManager: CLLocationManager, mapView: MKMapView) {
        setupGeofenceMonitoring(for: annotation, radius: radius, locationManager: locationManager)
        drawGeofenceCircle(center: annotation.coordinate, radius: radius, mapView: mapView)
        print("Geofence set for annotation at \(annotation.coordinate) with radius \(radius) meters.")
    }
}
