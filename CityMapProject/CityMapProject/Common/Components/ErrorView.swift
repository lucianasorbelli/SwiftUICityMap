//
//  ErrorView.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import SwiftUI

import SwiftUI

struct ErrorScreenView: View {
    
    var retryAction: () -> Void
    
    init(retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: String.exclamationMark)
                .resizable()
                .frame(width: .size80,
                       height: .size80)
                .foregroundColor(.yellow)
                .padding(.bottom, .padding20)
            
            Text(String.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .padding20)
            
            Spacer()
            Button(action: {
                retryAction()
            }) {
                Text(String.retry)
                    .font(.body)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(.radius10)
            }
            .padding(.horizontal, .padding20)
            .padding(.bottom, .padding20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

private extension CGFloat {
    static let padding20: CGFloat = 20
    static let radius10: CGFloat = 10
    static let radius12: CGFloat = 12
    static let size80: CGFloat = 80
}

private extension String {
    static let retry = "Intentar nuevamente"
    static let title = "Algo anduvo mal. Intente nuevamente más tarde"
    static let exclamationMark  = "exclamationmark.triangle.fill"
}
