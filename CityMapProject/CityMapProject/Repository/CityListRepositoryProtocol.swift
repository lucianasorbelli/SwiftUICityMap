//
//  CityListRepositoryProtocol.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

protocol CityListRepositoryProtocol {
    func fetchCities() async throws -> CitiesModel
}
