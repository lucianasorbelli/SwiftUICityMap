//
//  ContentView.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 06/11/2024.
//

import SwiftUI

struct CityListView<ViewModel>: View where ViewModel: CityListViewModeling {
    
    @StateObject private var viewModel: ViewModel
    @State private var navigationPath = NavigationPath()
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack{
                switch viewModel.viewState {
                case .success:
                    successView
                case .error:
                    EmptyView()
                case .loading:
                    EmptyView()
                }
            }
            .onAppear(perform: viewModel.fetchCities)
            .navigationDestination(for: CityModel.self) { city in
                //navigate to mapView with city
            }
        }
    }
    
    private var successView: some View {
        List(viewModel.cities) { city in
            CityCell(city: city, action: {
                navigationPath.append(city)
            }).onAppear {
                if (city.id == viewModel.cities.last?.id) && (viewModel.hasMoreCitiesToLoad) {
                    viewModel.loadMoreCities()
                }
            }
        }
    }
}
