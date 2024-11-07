//
//  CitiesModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

typealias CitiesModel = [CityModel]

final class CityModel: Codable, Identifiable, ObservableObject, Hashable {
    var country, name: String
    var id: Int
    var coord: Coordinate
    @Published var isFavorite: Bool = false
    var description: String { "Lat: \(coord.lat), Lon:\(coord.lon)"}
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    init(country: String,
         name: String,
         id: Int,
         coord: Coordinate,
         isFavorite: Bool = false) {
        self.country = country
        self.name = name
        self.id = id
        self.coord = coord
        self.isFavorite = isFavorite
    }
    
    public func hash(into hasher: inout Hasher) { hasher.combine(id) }
    public static func == (lhs: CityModel, rhs: CityModel) -> Bool { lhs.id == rhs.id }
}

struct Coordinate: Codable {
    let lon, lat: Double
}
