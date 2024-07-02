//
//  SearchView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var city: String = ""
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var answer: weatherData?
    
    var body: some View {
        VStack {
            TextField("Enter city name", text: $city)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.responseUpload()
            }) {
                Text("Search")
            }
            .padding()
            
            if let answer = answer {
                Text("Temperature: \(Int(answer.temprature))°C")
                Text("Humidity: \(answer.humidity)%")
                Text("Wind Speed: \(answer.wind) m/s")
                Text("Description: \(answer.condition)")
            } else {
                Text("No data available")
            }
        }
        .padding()
    }
}

#Preview {
    SearchView()
}
