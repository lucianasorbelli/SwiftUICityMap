//
//  Enums.swift
//  CityMapProject
//
//  Created by Luciana Sorbelli on 07/11/2024.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse(error: Error)
    case statusCode(Int)
}
