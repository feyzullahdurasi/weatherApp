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
    
    static var dateformatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM E H:mm"
        return dateFormatter
    }
    
    static var numberFormatter: NumberFormatter {
        let numberFormetter = NumberFormatter()
        numberFormetter.maximumFractionDigits = 0
        return numberFormetter
    }
    
    static var numberFormatter2: NumberFormatter {
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
    
    func convert2() -> String {
        var tempdegree = "°C"
        if system == 0 {
            return tempdegree
        } else {
            tempdegree = "°F"
            return tempdegree
        }
    }
    var day: String {
        return ForecastViewModel.dateformatter.string(from: forecast.dt)
        
    }
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var temperature: String {
        return "\(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp) as NSNumber) ?? "0")\(convert2())"
    }
    var weatherIconURL: URL {
        let urlString1 = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString1)!
    }
}
