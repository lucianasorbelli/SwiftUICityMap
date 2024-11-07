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
            .navigationDestination(for: CityModel.self) { city in
                CityMapView(viewModel: viewModel.getMapViewModel(for: city))
            }
        }
    }
    
    private var successView: some View {
        VStack{
            TextField(String.searchCity, text: $viewModel.searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            List(viewModel.cities) { city in
                CityCell(
                    city: city,
                    onTapCell: { navigationPath.append(city) },
                    onCheckFavorite: { favorite in
                        self.viewModel.updateFavorite(for: city, setValue: favorite)
                    }).padding()
                    .onAppear {
                        if (city.id == viewModel.cities.last?.id) && (viewModel.hasMoreCitiesToLoad) {
                            viewModel.loadMoreCities()
                        }
                    }
            }
        }
    }
}

private extension String {
    static let searchCity = "Buscar ciudad"
}
