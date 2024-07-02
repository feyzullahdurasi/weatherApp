//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import Foundation
import CoreLocation


class WeatherViewModel: ObservableObject {
    
    func responseUpload(){
        let key = "c75fa45f4752adf0fa8c01456807b64d"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=\(key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            do{
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data!)
                
                    DispatchQueue.main.async {
                        weatherData(
                            wind: weatherResponse.wind,
                            temprature: weatherResponse.main.temp,
                            humidity: weatherResponse.main.humidity,
                            condition: weatherResponse.weather.first?.description ?? "")
                    }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
        
    }
    
    
    
    
}
