import Foundation
import CoreData
import UIKit

class CoreDataHelper {

    static let shared = CoreDataHelper()

    private init() {}

    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GeoForceReminderApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - CRUD Operations
    func saveGeofence(name: String, latitude: Double, longitude: Double, radius: Double, note: String?) {
        let geofence = GeofenceReminder(context: context)
        geofence.name = name
        geofence.latitude = latitude
        geofence.longitude = longitude
        geofence.radius = radius
        geofence.note = note
        saveContext()
    }

    func fetchGeofences() -> [GeofenceReminder] {
        let fetchRequest: NSFetchRequest<GeofenceReminder> = GeofenceReminder.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch geofences: \(error)")
            return []
        }
    }
}
