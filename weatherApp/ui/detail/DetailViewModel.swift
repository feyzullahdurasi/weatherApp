//
//  DetailViewModel.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 5.07.2024.
//

import Foundation

struct DetailViewModel {
    let forecast: Forecast.List
    var system: Int
    
    var day: String {
        return ForecastViewModel.dateformatter.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    func convert2() -> String {
        var tempdegree = "°C"
        if system == 0 {
            return tempdegree
        } else {
            tempdegree = "°F"
            return tempdegree
        }
    }
    
    var temperature: String {
        return " \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp) as NSNumber) ?? "0")\(convert2())"
    }
    
    var High: String {
        return "Max: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_max) as NSNumber) ?? "0")\(convert2())"
    }
    
    var Low: String {
        return "Min: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_min) as NSNumber) ?? "0")\(convert2())"
    }
    
    var wind: String {
        return "💨 \(forecast.wind.speed)km/s"
    }
    
    var clouds: String {
        return "☁️\(forecast.clouds)"
    }
    
    var humidity: String {
        return "Humidity: \(forecast.main.humidity)%"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
    
    private func convert(_ temp: Double) -> Double {
        let celcius = temp - 273.5
        if system == 0 {
            return celcius
        } else {
            return celcius * 9 / 5 + 32
        }
    }
}
