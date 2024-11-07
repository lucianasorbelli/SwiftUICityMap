//
//  CityCell.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Combine
import SwiftUI

struct CityCell: View {
    
    private var onTapCell: () -> Void
    @ObservedObject var city: CityModel
    private var onCheckFavorite: (Bool) -> Void
    
    init(city: CityModel,
         onTapCell: @escaping () -> Void,
         onCheckFavorite: @escaping (Bool) -> Void) {
        self.city = city
        self.onTapCell = onTapCell
        self.onCheckFavorite = onCheckFavorite
    }
    
    var body: some View {
        Button(action: { onTapCell() },
               label: {
            VStack(alignment: .leading, spacing: .size16){
                titleSection
                subtitleSection
            }
        })
        .padding(.horizontal, .zero)
    }
    
    private var titleSection: some View {
        HStack(alignment: .center, spacing: .zero) {
            HStack(alignment: .center, spacing: .size10) {
                Text(city.name)
                Text(city.country)
            }
            .font(.headline)
            .foregroundStyle(.black)
            Spacer()
            Image(systemName: city.isFavorite ? .heartFill : .heart)
                .foregroundColor(city.isFavorite ? .red : .gray)
                .font(.system(size: .size16))
                .onTapGesture {
                    onCheckFavorite(!city.isFavorite)
                }
        }
    }
    
    private var subtitleSection: some View {
        HStack(alignment: .center, spacing: .zero){
            Text(city.description)
                .font(.body)
                .foregroundStyle(.gray)
            Spacer()
        }
    }
}

private extension String {
    static let heart: String = "heart"
    static let heartFill: String = "heart.fill"
}

private extension CGFloat {
    static let size10: CGFloat = 10.0
    static let size16: CGFloat = 16.0
}
