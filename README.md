# GeoForceReminderApp
## Overview
GeoForceReminderApp is an iOS application that allows users to set geofence-based reminders. Users can define geofence regions on a map, associate them with custom notes, and receive notifications when entering or exiting these regions.

## Features
- **Geofence Management**: Create geofences by selecting a location on the map and specifying a radius and note.
- **Core Data Integration**: Save and fetch geofence reminders for persistence.
- **Local Notifications**: Receive notifications when entering or exiting geofence regions.
- **Interactive Map**: Visualize geofences on the map with annotations and overlays.
- **Locations List**: View all saved geofences in a list format.

## Usage
1. **Set a Geofence**:
   - Tap on a location on the map.
   - Enter the radius (100-1000 meters) and an optional note.
   - Save the geofence.
2. **View Geofences**:
   - Open the Locations List from the menu.
   - View all saved geofences and their details.
3. **Receive Notifications**:
   - Ensure location permissions are granted.
   - Notifications will trigger when entering or exiting geofence regions.

## Technical Details
- **Core Data**: Used for persisting geofence data.
- **MapKit**: Used for map interactions and geofence visualization.
- **UserNotifications**: Used for triggering local notifications.
- **Combine Framework**: Used for reactive bindings between the ViewModel and ViewController.

## File Structure
- `GeoForceViewController.swift`: Main view controller for managing geofences.
- `GeoForceViewModel.swift`: Handles geofence logic and data binding.
- `LocationsListViewController.swift`: Displays saved geofence reminders.
- `CoreDataHelper.swift`: Provides helper methods for Core Data operations.

## Permissions
- **Location Services**: Required for geofence monitoring.
- **Notifications**: Required for sending local notifications.

## Notes
- Ensure location services are enabled for the app.
- Notifications must be allowed to receive geofence alerts.

## Future Enhancements
- Add functionality to edit or delete geofence reminders.
- Enhance UI/UX for better user interaction.
- Support for multiple geofence regions simultaneously.

## Debugging Notes
- Fixed duplicate geofence monitoring by ensuring unique identifiers.
- Added debugging logs to trace method calls and ensure proper flow.

## Author
GeoForce Reminder App Team
