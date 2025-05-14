//
//  LocationsListViewController.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 14/05/2025.
//

import Foundation
import UIKit
import CoreData

class LocationsListViewController: UIViewController {

    // MARK: - Properties
    private var viewModel = LocationsListViewModel()
    private var geofences: [GeofenceReminder] = []
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "List is empty"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    @IBOutlet weak var tableView: UITableView!
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupEmptyLabel()
        title = "Locations"
        viewModel.loadGeofences()
        emptyLabel.isHidden = !viewModel.isGeofenceListEmpty()
        tableView.reloadData()
    }

    // MARK: - Setup Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
    }

    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension LocationsListViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.geofences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let geofence = viewModel.geofences[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = geofence.name
        return cell
    }
}
