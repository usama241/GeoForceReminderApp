//
//  GeoForceViewModel.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 12/05/2025.
//

import Foundation

class GeoForceViewModel: TableViewModel {
    
    var locations : [LocationsArray]? = []
    override init() {
        super.init()
        fetchData()
    }
    
    func fetchData() {
        self.getLocations { msg, success in
            self.prepareData()
        }
    }
    
    override func prepareData() {
        super.prepareData()
        let section = TableSectionData(model: self)
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }

    func getLocations(block: @escaping (String?, Bool) -> Void) {
        ActivityIndicator.shared.showLoadingIndicator()

        guard let url = URL(string: "https://gist.githubusercontent.com/usama241/41e0cdcac7055e83cd9665c3ad4af89f/raw/0131631c669dd492faaceb01dc3d417fd1034301/locations.json") else {
            block("Invalid URL", false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                ActivityIndicator.shared.hideLoadingIndicator()

                if let error = error {
                    block(error.localizedDescription, false)
                    Utility.showAlert(title: "Uh-oh!", message: error.localizedDescription)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    block("Invalid response", false)
                    return
                }

                guard let data = data else {
                    block("No data received", false)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LocationsResponse.self, from: data)

                    if httpResponse.statusCode == 200 {
                        self.locations = response.locations
                        print(response)
                        block(nil, true)
                    } else if httpResponse.statusCode == 401 {
                        Utility.showAlert(title: "Uh-oh!", message: response.responseDescription ?? "")
                        block(nil, true)
                    } else {
                        if let msg = response.responseDescription {
                            Utility.showAlert(title: "Uh-oh!", message: msg)
                        }
                        block(nil, false)
                    }
                } catch {
                    block("Failed to decode response", false)
                    Utility.showAlert(title: "Uh-oh!", message: "Failed to decode response")
                }
            }
        }

        task.resume()
    }
}
