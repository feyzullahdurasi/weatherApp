//
//  ForecastListViewModel.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//

//import CoreLocation
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    
    @Published var forecasts: [ForecastViewModel] = []
    @AppStorage("location") var location: String = "524901"
    @AppStorage("system") var system: Int = 0 {
    
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }

    init() {
        if !location.isEmpty {
            Task {
                await getWeatherForecast()
            }
        }
    }

    
    func getWeatherForecast() async {
        let apiService = APIService.shared
        do {
            let forecast: Forecast = try await apiService.getJSON(urlString1: "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c75fa45f4752adf0fa8c01456807b64d")
            DispatchQueue.main.async {
                self.forecasts = forecast.list.map { ForecastViewModel(forecast: $0, system: self.system) }
            }
        } catch {
            print("Error fetching weather forecast: \(error)")
        }
    }
    
}
