//
//  weatherAppApp.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI

@main
struct weatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                WeatherView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                
            }
        }
    }
}
