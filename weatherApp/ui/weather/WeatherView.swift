//
//  WeatherView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct WeatherView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                    
                List(forecastListVM.forecasts, id: \.day) { day in
                        
                        VStack (alignment: .leading){
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                WebImage(url: day.weatherIconURL)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75)
                                VStack(alignment: .leading) {
                                    Text(day.overview)
                                    Text("Temprature: \(day.Temprature)")
                                    HStack {
                                        Text("Max Temprature: \(day.High)")
                                        Text("Min Temprature: \(day.Low)")
                                    }
                                    Text("Humidity: \(day.humidity)%")
                                    Text("Wind Speed: \(day.wind)")
                                    Text("Cloud: \(day.clouds)")
                                }
                            }
                        }
                           
                        
                    }
                    .listStyle(PlainListStyle())
                
                
            }
            .padding(.horizontal)
        .navigationTitle("Weather App")
        }
    }
    
    
    
}

#Preview {
    WeatherView()
}
