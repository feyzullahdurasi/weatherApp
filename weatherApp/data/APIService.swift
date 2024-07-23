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
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decoder.decode(T.self, from: data)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    enum APIError: Error {
            case invalidURL
            case invalidResponse(statusCode: Int)
            case decodingError(Error)
            case networkError(Error)
            
            var userErrorMessage: String {
                switch self {
                case .invalidURL:
                    return "Geçersiz bir URL ile karşılaşıldı. Lütfen URL'yi kontrol edin."
                case .invalidResponse(let statusCode):
                    return "Sunucu yanıtında bir hata oluştu. Durum kodu: \(statusCode)."
                case .decodingError:
                    return "Veri işlenirken bir hata oluştu."
                case .networkError:
                    return "Ağ bağlantısı sırasında bir hata oluştu."
                }
            }
        }
}
