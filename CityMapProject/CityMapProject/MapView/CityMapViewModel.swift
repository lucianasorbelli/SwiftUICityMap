//
//  CityMapViewModel.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Combine
import MapKit

protocol CityMapViewModeling: ObservableObject {
    var city: MapLocation { get }
    var viewState: CityMapViewModel.ViewState { get }
}

final class CityMapViewModel: CityMapViewModeling {
    enum ViewState { case ready, inProgress }
    @Published var city: MapLocation
    @Published var viewState: ViewState = .inProgress
    
    init(city: MapLocation) {
        self.city = city
        viewState = .ready
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: -78.49, longitude: -9.12)
    }
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
//-78.497498,"lat":-9.12417
