//
//  ForecastListViewModel.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//

//import CoreLocation
import Foundation

class ForecastListViewModel: ObservableObject {
    
    @Published var forecasts: [ForecastViewModel] = []
    var location: String = ""
    var system: Int = 0
    
    
     func getWeatherForecast() {
        let apiService = APIService.shared
        
        /*CLGeocoder().geocodeAddressString(location) { (placemarks, error ) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {*/
            if location == "İstanbul" {
                apiService.getJSON(urlString1: "http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c75fa45f4752adf0fa8c01456807b64d",
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
            }
                /*
            }
        }*/
    }
}
