//
//  CitiesModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

typealias CitiesModel = [CityModel]

struct CityModel: Codable, Identifiable {
    let country,
        name: String
    let id: Int
    let coord: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

struct Coordinate: Codable {
    let lon, lat: Double
}
