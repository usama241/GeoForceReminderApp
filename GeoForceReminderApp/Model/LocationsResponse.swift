//
//  LocationsResponse.swift
//  GeoForceReminderApp
//
//  Created by MacBook Pro on 12/05/2025.
//

import Foundation

struct LocationsResponse : Codable {
    let responseCode : Int?
    let responseDescription : String?
    let locations : [LocationsArray]?

    enum CodingKeys: String, CodingKey {

        case responseCode = "responseCode"
        case responseDescription = "responseDescription"
        case locations = "locations"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        responseDescription = try values.decodeIfPresent(String.self, forKey: .responseDescription)
        locations = try values.decodeIfPresent([LocationsArray].self, forKey: .locations)
    }

}

struct LocationsArray : Codable {
    let id : String?
    let name : String?
    let lat : Double?
    let lon : Double?
    let category : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case lat = "lat"
        case lon = "lon"
        case category = "category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        category = try values.decodeIfPresent(String.self, forKey: .category)
    }

}

