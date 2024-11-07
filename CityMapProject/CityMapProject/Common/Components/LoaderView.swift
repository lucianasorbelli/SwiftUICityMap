//
//  LoaderView.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import SwiftUI

struct LoaderView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(.opacity03)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(.scale15)
        }
    }
}

private extension Double {
    static let opacity03: Double = 0.3
}

private extension CGFloat {
    static let scale15: CGFloat = 1.5
}
