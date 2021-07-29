//
//  NetworkConstants.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation

//API URL
let BaseURL = "https://api.openweathermap.org"

//API Key
let APIKey = "0bc9bc2a73fd9644f664cf5f5c5be8d7"

//HTTPheaders enum with the needed headers
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

//ContenType enum for the needed content type params
enum ContentType: String {
    case json = "application/json"
}
