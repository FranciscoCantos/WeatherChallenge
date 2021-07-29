//
//  EndpointsConfiguration.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation
import Alamofire

// Endpoint configuration implementation.
enum EndpointsConfiguration: APIConfiguration {
        
    case getWeather(latitude: String, longitude: String)
    case getCityCountryWeather(city: String, country: String, isoCode: String)
 
    // HTTPMethods
    var method: HTTPMethod {
        switch self {
        case .getWeather, .getCityCountryWeather:
            return .get
        }
    }
    
    // Paths
    var path: String {
        switch self {
        case .getWeather, .getCityCountryWeather:
            return "/data/2.5/weather"
        }
    }
    
    // Query Items
    var queryItems: [URLQueryItem] {
        var defaultQueryItems = [URLQueryItem]()
        
        switch self {
        case .getWeather(let latitude, let longitude):
            defaultQueryItems.append(URLQueryItem(name: "lat", value: latitude))
            defaultQueryItems.append(URLQueryItem(name: "lon", value: longitude))
        case .getCityCountryWeather(let city, let country, let isoCode):
            defaultQueryItems.append(URLQueryItem(name: "q", value: "\(city),\(isoCode),\(country)"))
        }
        
        defaultQueryItems.append(contentsOf: [URLQueryItem(name: "appid", value: APIKey),
                                  URLQueryItem(name: "units", value: "metric")])
        return defaultQueryItems
    }
        
    // URLRequest
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: BaseURL)!
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return urlRequest
    }
}
