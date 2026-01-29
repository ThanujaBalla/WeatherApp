//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//
import Foundation

struct WeatherRequest {
let latitude: Double
let longitude: Double
}

struct WeatherEndpoint: APIEndpoint {

let request: WeatherRequest

var baseURL: String { "https://api.open-meteo.com"
}

var path: String {
"/v1/forecast"
}

var queryItems: [URLQueryItem] {
[
URLQueryItem(name: "latitude", value: "\(request.latitude)"),
URLQueryItem(name: "longitude", value: "\(request.longitude)"),
URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,windspeed_10m,visibility,showers,weathercode")


]
}
}

