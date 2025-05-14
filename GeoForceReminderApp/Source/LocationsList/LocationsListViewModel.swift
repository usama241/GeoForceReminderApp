//
//  LocationsListViewModel.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 14/05/2025.
//

import Foundation
import CoreData

class LocationsListViewModel {

    // MARK: - Properties
    private(set) var geofences: [GeofenceReminder] = []

    // MARK: - Initializer
    init() {
        
    }

    // MARK: - Methods
    func loadGeofences() {
        geofences = CoreDataHelper.shared.fetchGeofences()
    }

    func isGeofenceListEmpty() -> Bool {
        return geofences.isEmpty
    }
}
