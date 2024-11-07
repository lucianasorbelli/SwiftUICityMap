//
//  CityMapView.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import SwiftUI
import MapKit

struct CityMapView<ViewModel>: View where ViewModel: CityMapViewModeling {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        Map(interactionModes: [.pan, .zoom]){
            Annotation(viewModel.city.name,
                       coordinate: viewModel.city.coordinate) {
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 30)
                    .overlay {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
            }
        }.mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.cafe])))
    }
}

