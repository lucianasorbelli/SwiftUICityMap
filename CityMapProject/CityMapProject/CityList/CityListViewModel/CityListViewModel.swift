//
//  CityListViewModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

protocol CityListViewModeling: ObservableObject {
    var cities: CitiesModel { get }
    var hasMoreCitiesToLoad: Bool { get }
    var viewState: CityListViewModel.ViewState { get }
    ///functions
    func fetchCities()
    func loadMoreCities()
}

final class CityListViewModel: CityListViewModeling {
    enum ViewState { case success, error, loading }
    
    private let pageSize = 50
    private var currentPage = 0
    private var allCities: CitiesModel = []
    @Published var cities: CitiesModel = []
    @Published var hasMoreCitiesToLoad = true
    @Published var viewState: ViewState = .loading
    private let repository: CityListRepositoryProtocol
    
    init(repository: CityListRepositoryProtocol = CityListRepository()){
        self.repository = repository
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
        let start = currentPage * pageSize
        let end = min(start + pageSize, allCities.count)
        
        guard start < end else {
            hasMoreCitiesToLoad = false
            return
        }
        
        cities.append(contentsOf: allCities[start..<end])
        currentPage += 1
        
        if cities.count >= allCities.count {
            hasMoreCitiesToLoad = false
        }
    }
    
    private func sort(_ cities: CitiesModel) -> CitiesModel {
        cities.sorted {
            if $0.name.lowercased() != $1.name.lowercased() {
                return $0.name.lowercased() < $1.name.lowercased()
            }
            return $0.country.lowercased() < $1.country.lowercased()
        }
    }
}
