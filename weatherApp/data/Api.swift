//
//  Api.swift
//  weatherApp
//
//  Created by Feyzullah Durası on 2.07.2024.
//

import Foundation
import CoreLocation

struct weatherData {
    var wind: Double
    var temprature: Double
    var humidity: Double
    var condition: String
    
    init(wind: Double, temprature: Double, humidity: Double, condition: String) {
        self.wind = wind
        self.temprature = temprature
        self.humidity = humidity
        self.condition = condition
    }
}

struct WeatherResponse: Codable {
    var main: Main
    var weather: [Weather]
    var wind: Double
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode(Main.self, forKey: .main)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.wind = try container.decode(Double.self, forKey: .wind)
    }
}

struct Main: Codable {
    var temp: Double
    var humidity: Double
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.humidity = try container.decode(Double.self, forKey: .humidity)
    }
}

struct Weather: Codable {
    var description: String
    var icon: String
    
    init(description: String, icon: String) {
        self.description = description
        self.icon = icon
    }
}

struct Wind: Codable {
    var speed: Double
    
    init(speed: Double) {
        self.speed = speed
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

