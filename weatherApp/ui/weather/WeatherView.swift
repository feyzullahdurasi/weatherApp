//
//  WeatherView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//


import SwiftUI
import SDWebImageSwiftUI

struct WeatherView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(forecastListVM.forecasts, id: \.day) { day in
                    NavigationLink(destination: DetailView(weatherDetailVM: DetailViewModel(forecast: day.forecast, system: day.system))) {
                        VStack(alignment: .leading) {
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                WebImage(url: day.weatherIconURL)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75)
                                Spacer()
                                
                                VStack {
                                    Text("\(day.temperature)")
                                        .font(.system(size: 30))
                                    Text(day.overview)
                                }
                                
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .padding(.horizontal)
            .navigationTitle("Weather App")
            
            .onAppear {
                Task {
                    await forecastListVM.getWeatherForecast()
                }
            }
        }
    }
    
}

#Preview {
    WeatherView()
}
