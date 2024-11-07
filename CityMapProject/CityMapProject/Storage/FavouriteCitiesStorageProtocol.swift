//
//  FavouriteCitiesStorage.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

protocol FavouriteCitiesStorageProtocol {
    func saveFavouriteCity(id: Int)
    func removeFavouriteCity(id: Int)
    func isFavouriteCity(id: Int) -> Bool
    func getAllFavouriteCities() -> [Int]
}
