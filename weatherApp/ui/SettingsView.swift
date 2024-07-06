//
//  SettingsView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 4.07.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var forecastListVM = ForecastListViewModel()
    @State private var changeTheme: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
            NavigationStack {
                List {
                    Section("Appearance"){
                        Picker(selection: $forecastListVM.system, label: Text("System")) {
                            Text("°C").tag(0)
                            Text("°F").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button("Chose Theme") {
                            changeTheme.toggle()
                        }.preferredColorScheme(userTheme.colorSheme)
                    }
                }
                .navigationTitle("Settings")
            }.sheet(isPresented: $changeTheme, content: {
                ThemeChangeView()
                    .presentationDetents([.height(410)])
                    .presentationBackground(.clear)
            })
            
            
    }
}

#Preview {
    SettingsView()
}

enum Theme : String, CaseIterable {
    case systemDefault = "default"
    case light = "light"
    case dark = "dark"
    
    var colorSheme: ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
