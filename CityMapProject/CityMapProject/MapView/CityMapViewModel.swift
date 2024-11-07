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
    var description: String { get }
    var showInfo: Bool { get set }
}

final class CityMapViewModel: CityMapViewModeling {
    
    @Published var city: MapLocation
    @Published var showInfo: Bool = false
    @Published var description: String = String()
    
    init(city: MapLocation) {
        self.city = city
        setupDescription()
    }
    
    private func setupDescription() {
        description = "Lat: \(city.latitude)\nLong: \(city.longitude)"
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
