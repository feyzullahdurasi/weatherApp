//
//  WeatherView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//


import SwiftUI

struct WeatherView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $forecastListVM.system, label: Text("System")) {
                    Text("C").tag(0)
                    Text("F").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
                .padding(.vertical)
                HStack {
                    TextField("Location", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        
                        forecastListVM.getWeatherForecast()
                    } label: {
                        Image(systemName:"magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                    
                }
                    
                List(forecastListVM.forecasts, id: \.day) { day in
                        
                        VStack (alignment: .leading){
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .top) {
                                Image(systemName: "hourglass")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
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
        .navigationTitle("Weather")
        }
    }
    
    
    
}

#Preview {
    WeatherView()
}
