//
//  APIService.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 3.07.2024.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func getJSON<T: Decodable>(urlString1: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) async throws -> T {
        guard let url = URL(string: urlString1) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return try decoder.decode(T.self, from: data)
    }
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case error(String)
    }
}
