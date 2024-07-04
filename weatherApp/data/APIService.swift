//
//  APIService.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 3.07.2024.
//


import UIKit

public class APIService {
    public static let shared = APIService()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString1: String,
                                      dateDecodeingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString1) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URl", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("error: data us corrut", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                completion(.success(decodeData))
                return
                
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
            
            
        }.resume()
    }
}
