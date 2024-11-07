//
//  CityMapProjectApp.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 06/11/2024.
//

import SwiftUI

@main
struct CityMapProjectApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = CityListViewModel()
            CityListView(viewModel: viewModel)
        }
    }
}
