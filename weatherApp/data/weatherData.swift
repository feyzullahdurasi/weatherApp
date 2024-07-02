//
//  weatherData.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import Foundation

    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "\(API.baseURL)weather?q=\(city)&appid=\(API.key)&units=metric"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                completion(weatherResponse)
            }
        }.resume()
    }
