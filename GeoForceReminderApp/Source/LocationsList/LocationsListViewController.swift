//
//  LocationsListViewController.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 14/05/2025.
//

import Foundation
import UIKit

class LocationsListViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: LocationsListViewModel!

    @IBOutlet weak var tableView: UITableView!
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Locations"
    }

    // MARK: - Setup Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
    }

    func configure(with viewModel: LocationsListViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource
extension LocationsListViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.textLabel?.text = viewModel.locations[indexPath.row].name
        return cell
    }
}
