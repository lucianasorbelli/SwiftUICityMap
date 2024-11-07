//
//  UIApplication+Extension.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        windows.filter { $0.isKeyWindow }.first?.endEditing(force)
    }
}
