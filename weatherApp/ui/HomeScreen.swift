//
//  HomeScreen.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = WeatherViewModel()

        var body: some View {
            VStack {
                if let weather = viewModel.weather {
                    VStack {
                        Text("Temperature: \(weather.main.temp, specifier: "%.1f")°C")
                        Text("Humidity: \(weather.main.humidity, specifier: "%.0f")%")
                        Text("Wind Speed: \(weather.wind.speed, specifier: "%.1f") m/s")
                        Text("Description: \(weather.weather.first?.description ?? "")")
                    }
                    .padding()
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                viewModel.fetchWeather(for: "Istanbul")
            }
        }
}

#Preview {
    HomeScreen()
}
