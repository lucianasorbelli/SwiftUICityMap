//
//  ContentView.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 06/11/2024.
//

import SwiftUI

struct CityListView<ViewModel>: View where ViewModel: CityListViewModeling {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
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
    }
    
    private var successView: some View {
        List(viewModel.cities) { city in
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.headline)
                Text(city.country)
                    .font(.subheadline)
            }
            .padding()
            .onAppear {
                if (city.id == viewModel.cities.last?.id) && (viewModel.hasMoreCitiesToLoad) {
                    viewModel.loadMoreCities()
                }
            }
        }
    }
}
