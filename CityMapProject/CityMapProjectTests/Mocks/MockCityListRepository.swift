//
//  MockCityListRepository.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

@testable import CityMapProject
import Foundation

class MockCityListRepository: CityListRepositoryProtocol {
    var shouldReturnError = false
    
    func fetchCities() async throws -> CitiesModel {
        if shouldReturnError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return [CityModel(country: "AR",
                          name: "Ciudad Autónoma de Buenos Aires",
                          id: 3433955,
                          coord: Coordinate(lon: -58.450001,
                                            lat: -34.599998))]
    }
}
