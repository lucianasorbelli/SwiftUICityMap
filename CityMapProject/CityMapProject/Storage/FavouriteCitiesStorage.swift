//
//  FavouriteCitiesStorage.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//
import Foundation

final class FavouriteCitiesStorage: FavouriteCitiesStorageProtocol {
    private let favouritesKey = "favouriteCities"
    
    init(){}
    
    func saveFavouriteCity(id: Int) {
        var favourites = getAllFavouriteCities()
        if !favourites.contains(id) {
            favourites.append(id)
            UserDefaults.standard.set(favourites, forKey: favouritesKey)
        }
    }
    
    func removeFavouriteCity(id: Int) {
        var favourites = getAllFavouriteCities()
        if let index = favourites.firstIndex(of: id) {
            favourites.remove(at: index)
            UserDefaults.standard.set(favourites, forKey: favouritesKey)
        }
    }
    
    func isFavouriteCity(id: Int) -> Bool {
        return getAllFavouriteCities().contains(id)
    }
    
    func getAllFavouriteCities() -> [Int] {
        return UserDefaults.standard.array(forKey: favouritesKey) as? [Int] ?? []
    }
}
