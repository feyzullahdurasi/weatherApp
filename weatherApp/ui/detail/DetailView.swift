//
//  DetailView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let weatherDetailVM: DetailViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(weatherDetailVM.day).bold()
                .font(.title2)
            
            WebImage(url: weatherDetailVM.weatherIconURL)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            VStack(alignment: .center) {
                
                    
                    
                    Text(weatherDetailVM.temperature)
                    .font(.system(size: 50))
                
                Text(weatherDetailVM.overview)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Text(weatherDetailVM.High)
                    Text(weatherDetailVM.Low)
                }
                
                Text(weatherDetailVM.humidity)
                Text(weatherDetailVM.wind)
                Text(weatherDetailVM.clouds)
            }.font(.title2)
                .padding()
            
            
            Spacer()
        }
        
        .padding()
    }
}


#Preview {
    DetailView(weatherDetailVM: DetailViewModel(forecast: Forecast.List(dt: Date(), main: Forecast.List.Main(temp: 300, temp_min: 295, temp_max: 305, humidity: 80), weather: [Forecast.List.Weather(id: 1, description: "Clear sky", icon: "01d")], clouds: Forecast.List.Clouds(all: 10), wind: Forecast.List.Wind(speed: 5)), system: 0))
}
