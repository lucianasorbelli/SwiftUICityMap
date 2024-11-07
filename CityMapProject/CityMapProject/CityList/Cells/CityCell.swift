//
//  CityCell.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Combine
import SwiftUI

import Combine
import SwiftUI

struct CityCell: View {
    @ObservedObject var city: CityModel
    private var action: () -> Void
    
    init(city: CityModel, action: @escaping () -> Void) {
        self.city = city
        self.action = action
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.headline)
                Text(city.country)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: { action() }) {
                Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(city.isFavorite ? .red : .gray)
                    .font(.system(size: 24))
                    .onTapGesture {
                        city.isFavorite.toggle()
                    }
            }
            .frame(width: 24.0, height: 24.0)
            .padding()
        }
        .padding()
    }
}

