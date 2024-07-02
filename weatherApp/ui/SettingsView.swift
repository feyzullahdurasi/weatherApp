//
//  SettingsView.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("temperatureUnit") private var temperatureUnit: String = "Celsius"

    var body: some View {
        VStack {
            Picker("Temperature Unit", selection: $temperatureUnit) {
                Text("Celsius").tag("Celsius")
                Text("Fahrenheit").tag("Fahrenheit")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Text("Selected unit: \(temperatureUnit)")
        }
        .padding()
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
