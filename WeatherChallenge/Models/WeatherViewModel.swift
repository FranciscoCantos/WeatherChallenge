//
//  WeatherViewModel.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation

struct WeatherViewModel {
    var iconName: String? = nil
    var description: String? = nil
    let temp, maxTemp, minTemp, feelsTemps: Double

    var iconURL: String? {
        if let iconName = self.iconName, !iconName.isEmpty {
            return "https://www.openweathermap.org/img/wn/\(iconName)@2x.png"
        } else { return nil }
    }
    
    var weatherDescription: String? {
        if !(description?.isEmpty ?? true) {
            return description
        } else { return nil }
    }
    
    init(apiResponse: WeatherResponse) {
        if let weatherModel = apiResponse.weather.first {
            iconName = weatherModel.icon
            description = weatherModel.weatherDescription
        }
        temp = apiResponse.main.temp
        maxTemp = apiResponse.main.tempMax
        minTemp = apiResponse.main.tempMin
        feelsTemps = apiResponse.main.feelsLike
    }
}
