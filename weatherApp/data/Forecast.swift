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
            
        }
        let weather: [Weather]
        struct Cloud: Codable {
            let all: Int
        }
        let clouds: Int
        struct Wind: Codable {
            let speed: Double
        }
        let wind: Wind
    }
    let list: [List]
}
//40.982099, 29.108262
//c75fa45f4752adf0fa8c01456807b64d

