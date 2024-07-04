//
//  ForecastViewModel.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.List
    var system: Int
    
    private static var dateformatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormetter = NumberFormatter()
        numberFormetter.maximumFractionDigits = 0
        return numberFormetter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormetter = NumberFormatter()
        numberFormetter.numberStyle = .percent
        return numberFormetter
    }
    
    func convert(_ temp: Double) -> Double {
        let celcius = temp - 273.5
        if system == 0 {
            return celcius
        } else {
            return celcius * 9 / 5 + 32
        }
    }
    var day: String {
        return ForecastViewModel.dateformatter.string(from: forecast.dt)
        
    }
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var Temprature: String {
        return "T: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp) as NSNumber) ?? "0")"
    }
    
    var High: String {
        return "H: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_max) as NSNumber) ?? "0")"
    }
    
    var Low: String {
        return "L: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_min) as NSNumber) ?? "0")"
    }
    
    var wind: String {
        return "💨 \(forecast.wind.speed)"
    }
    
    var clouds: String {
        return "☁️ \(forecast.clouds)"
    }
    
    var humidity: String {
        return "Humidity: \(ForecastViewModel.numberFormatter.string(from: forecast.main.humidity as NSNumber) ?? "0")%"
    }
}
