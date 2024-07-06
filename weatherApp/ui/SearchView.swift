//
//  SearchView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct SearchView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Location", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        Task {
                            await forecastListVM.getWeatherForecast()
                        }
                    } label: {
                        Image(systemName:"magnifyingglass.circle.fill")
                            .font(.title)
                    }
                    
                }
                    
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
            .navigationTitle("Search")
        }
    }
        
}

#Preview {
    SearchView()
}
