//
//  CityListViewModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

protocol CityListViewModeling: ObservableObject {
    var cities: CitiesModel { get }
    var searchText: String { get set }
    var hasMoreCitiesToLoad: Bool { get }
    var filteredCities: CitiesModel { get }
    var viewState: CityListViewModel.ViewState { get }
    ///functions
    func fetchCities()
    func loadMoreCities()
    func updateFavorite(for city: CityModel, setValue: Bool)
    func getMapViewModel(for city: CityModel) -> CityMapViewModel
}

final class CityListViewModel: CityListViewModeling {
    
    enum ViewState { case success, error, loading }
    
    private let pageSize = 50
    private var currentPage = 0
    @Published var searchText: String = "" {
        didSet {
            filterCities()
        }
    }
    private var allCities: CitiesModel = []
    @Published var cities: CitiesModel = []
    @Published var hasMoreCitiesToLoad = true
    @Published var viewState: ViewState = .loading
    @Published var filteredCities: CitiesModel = []
    private let storageHandler: FavouriteCitiesStorageProtocol
    private let repository: CityListRepositoryProtocol
    
    init(repository: CityListRepositoryProtocol = CityListRepository(),
         storageHandler: FavouriteCitiesStorageProtocol = FavouriteCitiesStorage()){
        self.repository = repository
        self.storageHandler = storageHandler
        self.fetchCities()
    }
    
    func fetchCities() {
        viewState = .loading
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let newCities: CitiesModel = try await repository.fetchCities()
                let sortedCities = sort(newCities)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.allCities = sortedCities
                    checkFavoritesCities()
                    self.loadMoreCities()
                    self.viewState = .success
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.viewState = .error
                }
            }
        }
    }
    
    func loadMoreCities() {
        
        guard searchText.isEmpty else { return }
        
        let start = currentPage * pageSize
        let end = min(start + pageSize, allCities.count)
        
        guard start < end else {
            hasMoreCitiesToLoad = false
            return
        }
        
        cities.append(contentsOf: allCities[start..<end])
        cities = cities.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        
        currentPage += 1
        
        if cities.count >= allCities.count {
            hasMoreCitiesToLoad = false
        }
    }
    
    func getMapViewModel(for city: CityModel) -> CityMapViewModel {
        let mapLocation = MapLocation(name: city.name, latitude: city.coord.lat, longitude: city.coord.lon)
        return CityMapViewModel(city: mapLocation)
    }
    
    private func sort(_ cities: CitiesModel) -> CitiesModel {
        cities.sorted {
            if $0.name.lowercased() != $1.name.lowercased() {
                return $0.name.lowercased() < $1.name.lowercased()
            }
            return $0.country.lowercased() < $1.country.lowercased()
        }
    }
    
    private func filterCities() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let currentPageCities = allCities.prefix(self.currentPage * self.pageSize)
            
            let filteredCities: CitiesModel
            if self.searchText.count < 2 {
                filteredCities = Array(currentPageCities)
            } else {
                filteredCities = allCities.filter { city in
                    city.name.lowercased().hasPrefix(self.searchText.lowercased())
                }
            }
            DispatchQueue.main.async {
                self.cities = filteredCities
            }
        }
    }
    
    private func checkFavoritesCities() {
        let favoriteCityIDs = UserDefaults.standard.array(forKey: "favouriteCities") as? [Int] ?? []
        allCities.filter { favoriteCityIDs.contains($0.id) }.forEach { city in
            city.isFavorite = true
        }
    }
    
    func updateFavorite(for city: CityModel, setValue: Bool) {
        setValue ? storageHandler.saveFavouriteCity(id: city.id) : storageHandler.removeFavouriteCity(id: city.id)
        city.isFavorite = storageHandler.isFavouriteCity(id: city.id)
    }
}
