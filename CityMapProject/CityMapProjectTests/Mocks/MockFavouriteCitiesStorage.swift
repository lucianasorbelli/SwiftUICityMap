//
//  MockFavouriteCitiesStorage.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

@testable import CityMapProject
import Foundation

class MockFavouriteCitiesStorage: FavouriteCitiesStorageProtocol {
    func getAllFavouriteCities() -> [Int] { return [1,2,3]}
    func saveFavouriteCity(id: Int) {}
    func removeFavouriteCity(id: Int) {}
    func isFavouriteCity(id: Int) -> Bool { return false}
}
