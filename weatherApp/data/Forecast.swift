//
//  Forecast.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 3.07.2024.
//

import Foundation

struct Forecast: Codable {
    struct List: Codable {
        let dt: Date
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let humidity: Int
        }
        let main: Main
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
            var weatherIconURL: URL {
                let urlString1 = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString1)!
            }
        }
        let weather: [Weather]
        let clouds: Int
        struct Wind: Codable {
            let speed: Double
        }
        let wind: Wind
    }
    let list: [List]
}
//40.982099, 29.108262

