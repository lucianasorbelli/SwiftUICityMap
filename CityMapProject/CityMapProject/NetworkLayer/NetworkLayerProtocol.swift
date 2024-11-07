//
//  NetworkLayerProtocol.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation
import Combine

protocol NetworkLayerProtocol {
    func performRequest<T: Decodable>(urlString: String,
                                      method: HTTPMethod,
                                      responseType: T.Type) async throws -> T
}
