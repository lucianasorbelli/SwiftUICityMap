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
        switch viewModel.viewState {
        case .ready:
            Map(interactionModes: [.pan, .zoom]){
                
                Annotation("Coffee Shop", coordinate: viewModel.city.coordinate) {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Image(systemName: "mappin.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
              
                    //Marker(viewModel.city.name, coordinate: viewModel.city.coordinate)
                }
                //
            }.mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.cafe])))
        case .inProgress:
            EmptyView()
        }
        
        
        //        Map((initialPosition: .region(MKCoordinateRegion(center: viewModel.city.coordinate, span: (MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))))) {
        //
        //        }
        
        
    }
}
    
