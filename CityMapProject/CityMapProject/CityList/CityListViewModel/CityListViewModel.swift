//
//  CityListViewModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

protocol CityListViewModeling: ObservableObject {
    var viewState: CityListViewModel.ViewState { get }
}


final class CityListViewModel: CityListViewModeling {
    enum ViewState { case success, error, loading }
    @Published var viewState: ViewState = .loading
    
}
