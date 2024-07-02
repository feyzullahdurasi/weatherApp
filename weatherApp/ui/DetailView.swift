//
//  DetailView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI

struct DetailView: View {
    let city: String
    @StateObject private var viewModel = WeatherViewModel()
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
        .onAppear {
            viewModel.responseUpload()
        }
        .padding()
    }
}


#Preview {
    DetailView(city: "Moscow")
}
