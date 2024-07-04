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
    @AppStorage("location") var location: String = ""
    @AppStorage("system") var system: Int = 0 {
    
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }
    
    init() {
        if location == "" {
            getWeatherForecast()
        }
    }
    
    
     func getWeatherForecast() {
        let apiService = APIService.shared
        
        /*CLGeocoder().geocodeAddressString(location) { (placemarks, error ) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {*/
            
                apiService.getJSON(urlString1: "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c75fa45f4752adf0fa8c01456807b64d",
                                   dateDecodeingStrategy: .secondsSince1970) {
                    (result: Result<Forecast,APIService.APIError>) in
                    
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.list.map { ForecastViewModel(forecast: $0, system: self.system) }
                        }
                        
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            
                /*
            }
        }*/
    }
}
