import WidgetKit
import SwiftUI
import SDWebImageSwiftUI

struct WeatherEntry: TimelineEntry {
    let date: Date
    let day: String
    let weatherIconURL: URL
    let temperature: String
    let overview: String
    let high: String
    let low: String
    let humidity: String
    let wind: String
    let clouds: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(
            date: Date(),
            day: "Monday",
            weatherIconURL: URL(string: "https://openweathermap.org/img/wn/01d@2x.png")!,
            temperature: "27°",
            overview: "Clear sky",
            high: "30°",
            low: "25°",
            humidity: "80%",
            wind: "5 km/s",
            clouds: "10%"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(
            date: Date(),
            day: "Monday",
            weatherIconURL: URL(string: "https://openweathermap.org/img/wn/01d@2x.png")!,
            temperature: "27°",
            overview: "Clear sky",
            high: "30°",
            low: "25°",
            humidity: "80%",
            wind: "5 km/s",
            clouds: "10%"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        Task {
            do {
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=c75fa45f4752adf0fa8c01456807b64d") else {
                    throw URLError(.badURL)
                }
                
                print("Starting network request...")
                let (data, response) = try await URLSession.shared.data(from: url)
                print("Network request completed. Response: \(response)")

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .deferredToDate
                let forecast = try decoder.decode(Forecast.self, from: data)

                let system = 0
                let viewModels = forecast.list.map { ForecastViewModel(forecast: $0, system: system) }

                var entries: [WeatherEntry] = []
                let currentDate = Date()

                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let viewModel = viewModels.first ?? ForecastViewModel(forecast: forecast.list[0], system: system)

                    let entry = WeatherEntry(
                        date: entryDate,
                        day: viewModel.day,
                        weatherIconURL: viewModel.weatherIconURL,
                        temperature: viewModel.temperature,
                        overview: viewModel.overview,
                        high: viewModel.High,
                        low: viewModel.Low,
                        humidity: viewModel.humidity,
                        wind: viewModel.wind,
                        clouds: viewModel.clouds
                    )
                    entries.append(entry)
                }

                let timeline = Timeline(entries: entries, policy: .after(Date(timeIntervalSinceNow: 15 * 60)))
                completion(timeline)
                // Widgetin 15 dakikada 1 tekrar güncellenmesini sağlar
            } catch {
                print("Error fetching weather forecast: \(error)")
            }
        }
    }
}

struct ForecastViewModel {
    let forecast: Forecast.List
    var system: Int

    static var dateformatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm EEEE"
        return dateFormatter
    }

    static var numberFormatter: NumberFormatter {
        let numberFormetter = NumberFormatter()
        numberFormetter.maximumFractionDigits = 0
        return numberFormetter
    }

    static var numberFormatter2: NumberFormatter {
        let numberFormetter = NumberFormatter()
        numberFormetter.numberStyle = .percent
        return numberFormetter
    }

    func convert(_ temp: Double) -> Double {
        let celcius = temp - 273.5
        if system == 0 {
            return celcius
        } else {
            return celcius * 9 / 5 + 32
        }
    }

    var day: String {
        return ForecastViewModel.dateformatter.string(from: forecast.dt)
    }

    var overview: String {
        forecast.weather[0].description.capitalized
    }

    var temperature: String {
        return "\(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp) as NSNumber) ?? "0")°C"
    }

    var High: String {
        return "Max: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_max) as NSNumber) ?? "0")°C"
    }

    var Low: String {
        return "Min: \(ForecastViewModel.numberFormatter.string(from: convert(forecast.main.temp_min) as NSNumber) ?? "0")°C"
    }

    var wind: String {
        return "💨 \(forecast.wind.speed) km/s"
    }

    var clouds: String {
        return "☁️ \(forecast.clouds.all)%"
    }

    var humidity: String {
        return "Humidity: \(forecast.main.humidity)%"
    }

    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return URL(string: "https://openweathermap.org/img/wn/01d@2x.png")!
        }
        return url
    }
}

struct Forecast: Codable {
    struct List: Codable {
        let dt: Date
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let humidity: Int
        }
        let main: Main
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
        }
        let weather: [Weather]
        struct Clouds: Codable {
            let all: Int
        }
        let clouds: Clouds
        struct Wind: Codable {
            let speed: Double
        }
        let wind: Wind
    }
    let list: [List]
}

struct SmallWeatherWidgetView: View {
    var entry: WeatherEntry

    var body: some View {
        VStack {
            Text(entry.day)
                .font(.headline)
            /*WebImage(url: entry.weatherIconURL)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)*/
            Image(systemName: "sun.max.fill")  // veya uygun başka bir sistem ikonu
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            
            Text(entry.temperature)
                .font(.title)
        }
        .padding()
    }
}

struct MediumWeatherWidgetView: View {
    var entry: WeatherEntry

    var body: some View {
        HStack(spacing: 30) {
            VStack {
                Text(entry.day)
                    .font(.headline)
                /*WebImage(url: entry.weatherIconURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)*/
                Image(systemName: "sun.max.fill")  // veya uygun başka bir sistem ikonu
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }
            
            VStack(alignment: .leading) {
                Text(entry.temperature)
                    .font(.title)
                Text(entry.overview)
                
                Text(entry.wind)
                Text(entry.clouds)
            }
        }
        .padding()
    }
}

struct LargeWeatherWidgetView: View {
    var entry: WeatherEntry

    var body: some View {
        VStack {
            Text(entry.day)
                .font(.headline)
           /* WebImage(url: entry.weatherIconURL)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)*/
            Image(systemName: "sun.max.fill")  // veya uygun başka bir sistem ikonu
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Text(entry.temperature)
                .font(.largeTitle)
            Text(entry.overview)
                .font(.title)
            HStack {
                Text(entry.high)
                Text(entry.low)
            }
            Text(entry.humidity)
            Text(entry.wind)
            Text(entry.clouds)
        }
        .padding()
    }
}


struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("Shows the current weather details.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct WeatherWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: WeatherEntry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWeatherWidgetView(entry: entry)
        case .systemMedium:
            MediumWeatherWidgetView(entry: entry)
        case .systemLarge:
            LargeWeatherWidgetView(entry: entry)
        @unknown default:
            Text("Unsupported widget size")
        }
    }
}

