//
//  WeatherApiModels.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
