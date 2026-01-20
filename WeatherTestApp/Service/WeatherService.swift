//
//  WeatherService.swift
//  WeatherTestApp
//
//  Created by Caio Aceti on 20/01/26.
//

import Foundation

class WeatherService {
    func fetchCoordinates(for city: String) async throws -> Location?  {

        let url = URL(
            string: "https://geocoding-api.open-meteo.com/v1/search?name=\(city)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder()
                .decode(LocationResponse.self, from: data).results?.first
    }

    func fetchWeather(for location: Location) async throws -> Weather {
        let url = URL(
            string: "https://api.open-meteo.com/v1/forecast?latitude=\(location.latitude)&longitude=\(location.longitude)&current_weather=true"
        )!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return response.current_weather
    }
}

struct WeatherResponse: Decodable {
    let current_weather: Weather
}

struct Weather: Decodable {
    let temperature: Double
    let weathercode: Int
}
