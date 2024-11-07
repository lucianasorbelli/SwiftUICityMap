//
//  NetworkLayer.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

import Foundation

enum ViewStates<T> {
    case success(T)
    case failure(Error)
}

final class NetworkLayer: NetworkLayerProtocol {
    
    static let shared = NetworkLayer()
    private init() {}
    
    func performRequest<T: Decodable>(urlString: String,
                                      method: HTTPMethod,
                                      responseType: T.Type) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse(error: NSError(domain: "Invalid Response",
                                                                 code: -1,
                                                                 userInfo: nil))
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkingError.statusCode(httpResponse.statusCode)
        }
        
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}

