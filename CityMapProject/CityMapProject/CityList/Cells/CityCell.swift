//
//  CityCell.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Combine
import SwiftUI

struct CityCell: View {
    @ObservedObject var city: CityModel
    private var onTapCell: () -> Void
    private var onCheckFavorite: (Bool) -> Void
    
    init(city: CityModel,
         onTapCell: @escaping () -> Void,
         onCheckFavorite: @escaping (Bool) -> Void) {
        self.city = city
        self.onTapCell = onTapCell
        self.onCheckFavorite = onCheckFavorite
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
            Button(action: { onTapCell() }) {
                Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(city.isFavorite ? .red : .gray)
                    .font(.system(size: 24))
                    .onTapGesture {
                        onCheckFavorite(!city.isFavorite)
                    }
            }
            .frame(width: 24.0, height: 24.0)
            .padding()
        }
        .padding()
    }
}

