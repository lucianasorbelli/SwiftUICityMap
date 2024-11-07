//
//  CityListRepository.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation
import Combine

final class CityListRepository: CityListRepositoryProtocol {
    
    private let networkingService: NetworkLayerProtocol
    private let cityURL = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    
    init(networkingService: NetworkLayerProtocol = NetworkLayer.shared){
        self.networkingService = networkingService
    }
    
    func fetchCities() async throws -> CitiesModel {
        let urlString = cityURL
        return try await networkingService.performRequest(
            urlString: urlString,
            method: .get,
            responseType: CitiesModel.self
        )
    }
}
