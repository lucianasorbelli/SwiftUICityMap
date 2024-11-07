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
}

final class CityMapViewModel: CityMapViewModeling {
    @Published var city: MapLocation
    
    init(city: MapLocation) {
        self.city = city
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, latitudinalMeters: 6500, longitudinalMeters: 6500)
    }
}
