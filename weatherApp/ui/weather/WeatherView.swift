//
//  ContentView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    @StateObject private var locationManager = LocationManager()
    @State private var answer: weatherData?
    var body: some View {
        VStack {
            if let answer = answer {
                Text("Temperature: \(Int(answer.temprature))°C")
                Text("Humidity: \(answer.humidity)%")
                Text("Wind Speed: \(answer.wind) m/s")
                Text("Description: \(answer.condition)")
            } else {
                ProgressView()
            }
        }
        .onAppear{
            locationManager.requestLocation()
            viewModel.responseUpload()
        }
        .onReceive(locationManager.$location) { location in
            
           /* guard let location = location else { return }
            viewModel.responseUpload*/
            // gelen veri tabanında sadece moscow için bilgi geliyor.
        }
        
        
    }

}

#Preview {
    WeatherView()
}
