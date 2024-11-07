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
        switch viewModel.viewState {
        case .success:
            EmptyView()
        case .error:
            EmptyView()
        case .loading:
            EmptyView()
        }
    }
}
